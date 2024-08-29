import 'dart:io';

import 'package:adsmanagement/features/cetegories/data/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/exception.dart';

abstract class CategoryRemoteDatasource{
  Future<List<CategoryModel>> getAllCategories();
  // Future<Unit> updateLike(AdModel model, String adId);
  Future<Unit> deleteCategory(String catId);
  Future<Unit> addCategory(CategoryModel model, File image);
}
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final String COLLECTION_NAME='categories';

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource{
  @override

  Future<List<CategoryModel>> getAllCategories() async{
    try {
      final querySnapshot = await _firestore
          .collection(COLLECTION_NAME)
          .orderBy('categoryUid', descending: true)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => CategoryModel.fromJson(doc.data()))
            .toList();
      } else {
        throw Exception("No ads found for this category");
      }
    } catch (e) {
      throw ServerException();
    }
  }


  @override
  Future<Unit> deleteCategory(String catId)async{
    await _firestore.collection(COLLECTION_NAME).doc(catId).delete();
    return Future.value(unit);
  }
  @override
  Future<Unit> addCategory(CategoryModel model, File image)async{
    final documentRef = await _firestore.collection(COLLECTION_NAME).add(model.toJson());
    final categoryId = model.categoryId;
    final categoryUid = documentRef.id;
    await documentRef.update({'categoryId': categoryId, 'categoryUid': categoryUid});
    return Future.value(unit);
  }


}