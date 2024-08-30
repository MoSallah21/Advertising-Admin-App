part of 'cat_bloc.dart';


abstract class CatEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class GetAllCategoriesEvent extends CatEvent{
  GetAllCategoriesEvent();
}

class RefreshCategoriesEvent extends CatEvent{

  RefreshCategoriesEvent();
}

class AddCategoryEvent extends CatEvent{
  final Category cat;
  final File image;
  AddCategoryEvent({required this.cat,required this.image});
  @override
  List<Object?> get props => [cat];
}
class DeleteCategoryEvent extends CatEvent{
  final String catId;

  DeleteCategoryEvent({required this.catId});

  @override
  List<Object?> get props => [catId];
}
