part of 'cat_bloc.dart';

abstract class CatState{}

class CatInitState extends CatState{}


class GetAllCategoriesSuccessState extends CatState{
  final List<Category> categories;

  GetAllCategoriesSuccessState({required this.categories});

}

class GetAllCategoriesErrorState extends CatState{
  final String message;

  GetAllCategoriesErrorState({required this.message});
}

class GetAllCategoriesLoadingState extends CatState{}


// add Category
class AddDeleteCategoryLoadingState  extends CatState{}

class AddDeleteCategorySuccessState  extends CatState{
  final String message;

  AddDeleteCategorySuccessState({required this.message});
}

class AddDeleteCategoryErrorState  extends CatState{
  final String message;

  AddDeleteCategoryErrorState({required this.message});
}

//pickCatPhoto

class AppCategoryPickedPhotoSuccessState  extends CatState{}

class AppCategoryPickedPhotoErrorState  extends CatState{}



//notification
class NotificationSuccessStatus extends CatState{}

class NotificationLoadingStatus extends CatState{}

class NotificationErrorStatus extends CatState{}
//vip
class ChangeVip extends CatState{}
