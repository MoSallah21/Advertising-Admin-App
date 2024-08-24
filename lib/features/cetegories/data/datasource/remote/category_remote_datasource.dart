import 'dart:io';

import 'package:adsmanagement/features/ads/data/models/ad.dart';
import 'package:adsmanagement/features/cetegories/data/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../../../core/errors/exception.dart';

abstract class CategoryRemoteDatasource{
  Future<List<CategoryModel>> getAllCategories();
  // Future<Unit> updateLike(AdModel model, String adId);
  Future<Unit> deleteCategory(String catId);
  Future<Unit> addCategory(CategoryModel model, File image);
}
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource{
  @override

  Future<List<AdModel>> getAllCategories() async{
    try {
      final querySnapshot = await _firestore
          .collection('ads')
          .orderBy('startDate', descending: true)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => AdModel.fromJson(doc.data()))
            .toList();
      } else {
        throw Exception("No ads found for this category");
      }
    } catch (e) {
      throw ServerException();
    }
  }

  // @override
  // Future<Unit> updateLike(AdModel model, String adId)async {
  //   await _firestore.collection("ads").doc(adId).update(model.toJson());
  //   return Future.value(unit);
  //
  // }

  @override
  Future<Unit> deleteAd(String adId)async {
    final adsRef = _firestore.collection('ads');
    final adDoc = adsRef.doc(adId);
      await adDoc.delete();
      return Future.value(unit);

  }

  // Add ad
  Future<Unit> addAd(AdModel model, File image) async {
    final storageRef = firebase_storage.FirebaseStorage.instance.ref().child('ads/${Uri.file(image.path).pathSegments.last}');
    final uploadTask = await storageRef.putFile(image);
    final imageUrl = await uploadTask.ref.getDownloadURL();
    model.image = imageUrl;
    final adDoc = await _firestore.collection('ads').add(model.toJson());
    final adId = adDoc.id;
    model.adId = adId;
    await adDoc.update({'adId': adId});
    return Future.value(unit);
  }


}