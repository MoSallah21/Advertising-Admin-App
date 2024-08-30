import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/features/cetegories/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteCategoryUseCase{
  final CategoryRepository repository;

  DeleteCategoryUseCase(this.repository);
  Future<Either<Failure,Unit>> call(String catId)async{
    return await repository.deleteCategory(catId);
  }
}