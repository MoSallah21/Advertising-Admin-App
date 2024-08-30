import 'dart:io';
import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/features/cetegories/domain/entities/category.dart';
import 'package:adsmanagement/features/cetegories/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class AddCategoryUseCase{
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);
  Future<Either<Failure,Unit>> call(Category cat,File image)async{
    return await repository.addCategory(cat,image) ;

  }
}