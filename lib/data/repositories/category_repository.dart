import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  CategoryRepository({required this.firestore, required this.storage});

  Future<String> uploadCategoryImage(String imagePath) async {
    final storageRef = storage.ref().child('category/${Uri.file(imagePath).pathSegments.last}');
    final uploadTask = await storageRef.putFile(File(imagePath));
    return await uploadTask.ref.getDownloadURL();
  }

  Future<int> getNextCategoryId() async {
    final snapshot = await firestore.collection('categories').get();
    if (snapshot.size > 0) {
      int maxCategoryId = snapshot.docs.map((doc) => doc['categoryId']).fold(0, (max, categoryId) => categoryId > max ? categoryId : max);
      return maxCategoryId + 1;
    } else {
      return 1;
    }
  }

  Future<void> addCategory(CategoryModel model) async {
    final documentRef = await firestore.collection('categories').add(model.toJson());
    final categoryId = model.categoryId;
    final categoryUid = documentRef.id;
    await documentRef.update({'categoryId': categoryId, 'categoryUid': categoryUid});
  }

  Future<void> deleteCategory(String? categoryUid) async {
    await firestore.collection('categories').doc(categoryUid).delete();
  }
}