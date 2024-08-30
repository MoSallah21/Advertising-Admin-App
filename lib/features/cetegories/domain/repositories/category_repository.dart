import 'dart:io';
import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/features/cetegories/domain/entities/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure,List<Category>>> getAllCategories();

  Future<int> getNextCategoryId();
  Future<Either<Failure,Unit>> deleteCategory(String catId);
  Future<Either<Failure,Unit>> addCategory(Category model, File image);

}