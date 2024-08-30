import 'dart:io';

import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/core/strings/failures.dart';
import 'package:adsmanagement/features/cetegories/domain/entities/category.dart';
import 'package:adsmanagement/features/cetegories/domain/usecases/add_category.dart';
import 'package:adsmanagement/features/cetegories/domain/usecases/delete_category.dart';
import 'package:adsmanagement/features/cetegories/domain/usecases/get_all_categories.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cat_event.dart';
part 'cat_status.dart';

class CatBloc extends Bloc<CatEvent,CatState>{
  final GetAllCategoriesUseCase getAllCategories;
  final AddCategoryUseCase addCategory;
  final DeleteCategoryUseCase deleteCategory;

  CatBloc({required this.getAllCategories,required this.addCategory,required this.deleteCategory}):super(CatInitState()) {
    on<CatEvent>((event,emit)async{
      if(event is GetAllCategoriesEvent){
        emit(GetAllCategoriesLoadingState());
        final failureOrPosts =await getAllCategories.call();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
      else if(event is RefreshCategoriesEvent){
        emit(GetAllCategoriesLoadingState());
        final failureOrPosts =await getAllCategories.call();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
      else if(event is AddCategoryEvent){
        emit(AddDeleteCategoryLoadingState());
        final failureOrSuccess=await addCategory(event.cat,event.image);
        emit(_addOrDelete(failureOrSuccess,"Add post success"));
      }
      else if(event is DeleteCategoryEvent){
        emit(AddDeleteCategoryLoadingState());
        final failureOrSuccess=await deleteCategory(event.catId);
        emit(_addOrDelete(failureOrSuccess,"Delete post success"));
      }
    });
  }
  Stream<List<Category>> get adsStream async* {
    await for (final state in stream) {
      if (state is GetAllCategoriesSuccessState) {
        yield state.categories;
      }
    }
  }
  }
  CatState _mapFailureOrPostsToState(Either<Failure,List<Category>> either)  {
    return either.fold(
          (failure)=>GetAllCategoriesErrorState(message: _mapFailureToMessage(failure)),
          (categories)=> GetAllCategoriesSuccessState(categories: categories),
    );
  }
  String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OffLineFailure:
        return OFF_LINE_FAILURE_MESSAGE;
      default: return "Unexpected error, please try again later";
    }
  }
CatState _addOrDelete(Either<Failure,Unit> either,message){
  return either.fold(
        (failure)=>AddDeleteCategoryErrorState(message: _mapFailureToMessage(failure)),
        (_)=> AddDeleteCategorySuccessState(message:message ),
  );
}

