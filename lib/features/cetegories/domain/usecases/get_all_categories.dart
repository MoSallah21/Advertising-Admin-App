import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/features/cetegories/domain/entities/category.dart';
import 'package:adsmanagement/features/cetegories/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';


class GetAllCategoriesUseCase{
  final CategoryRepository repository;

  GetAllCategoriesUseCase(this.repository);

  Future<Either<Failure,List<Category>>> call () async
  => await repository.getAllCategories();

}