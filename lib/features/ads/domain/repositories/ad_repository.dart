import 'dart:io';

import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/features/ads/domain/entities/ad.dart';
import 'package:adsmanagement/features/ads/domain/entities/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure,List<Category>>> getAllCategories(String catName);

  // Future<Either<Failure,Unit>> updateLike(Ad model, String adId);

  Future<Either<Failure,Unit>> deleteCategory(String adId);
  Future<Either<Failure,Unit>> addCategory(Ad model, File image);

}