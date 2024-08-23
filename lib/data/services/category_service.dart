import 'dart:io';

import 'package:adsmanagement/data/repositories/category_repository.dart';
import 'package:adsmanagement/models/category/category.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryService {
  final CategoryRepository repository;
  final FirebaseStorage storage;
  CategoryService( this.storage, {required this.repository});


  Future<String> uploadCategoryImage(String imagePath) async {
    final storageRef = storage.ref().child('category/${Uri.file(imagePath).pathSegments.last}');
    final uploadTask = await storageRef.putFile(File(imagePath));
    return await uploadTask.ref.getDownloadURL();
  }

  Future<void> addCategory({required String name, required String imagePath}) async {
    final imageUrl = await repository.uploadCategoryImage(imagePath);
    final nextCategoryId = await repository.getNextCategoryId();
    CategoryModel model = CategoryModel(
      title: name,
      image: imageUrl,
      categoryId: nextCategoryId,
    );
    await repository.addCategory(model);
  }

  Future<void> deleteCategory(String? categoryUid) async {
    await repository.deleteCategory(categoryUid);
  }
}