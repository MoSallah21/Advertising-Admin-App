import 'dart:io';
import 'package:adsmanagement/core/errors/exception.dart';
import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/core/network/local/remot/network_info.dart';
import 'package:adsmanagement/features/cetegories/data/datasource/local/category_local_datasource.dart';
import 'package:adsmanagement/features/cetegories/data/datasource/remote/category_remote_datasource.dart';
import 'package:adsmanagement/features/cetegories/data/models/category.dart';
import 'package:adsmanagement/features/cetegories/domain/entities/category.dart';
import 'package:adsmanagement/features/cetegories/domain/repositories/category_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
typedef Future<Unit> DeleteOrAddOr();

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class CategoryRepositoryImpl implements CategoryRepository{
  final CategoryRemoteDatasource remoteDatasource;
  final CategoryLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({required this.remoteDatasource, required this.localDatasource, required this.networkInfo});
  @override
  Future<Either<Failure, List<Category>>> getAllCategories()async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCats = await remoteDatasource.getAllCategories();
        localDatasource.cacheCategories(remoteCats);
        return Right(remoteCats);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCats = await localDatasource.getCachedCategories();
        return Right(localCats);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(String catId) async{
    return await _getMessage(() => remoteDatasource.deleteCategory(catId));
  }

  @override
  Future<Either<Failure, Unit>> addCategory(Category cat, File image)async {
    final CategoryModel categoryModel=CategoryModel(
        title: cat.title,
        categoryUid: cat.categoryUid,
        categoryId: cat.categoryId,
        image: cat.image,

    );
    return await _getMessage(() => remoteDatasource.addCategory(categoryModel,image));
  }
  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrAddOr deleteOrAddAd) async {
      try {
        await deleteOrAddAd();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }

  @override
  Future<int> getNextCategoryId()async {
    final snapshot = await _firestore.collection('categories').get();
    if (snapshot.size > 0) {
      int maxCategoryId = snapshot.docs.map((doc) => doc['categoryId']).fold(0, (max, categoryId) => categoryId > max ? categoryId : max);
      return maxCategoryId + 1;
    } else {
      return 1;
    }
  }
  }



