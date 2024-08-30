
import 'package:adsmanagement/features/cetegories/domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel(
      {
        required super.title,
        required super.image,
        required super.categoryId,
        required super.categoryUid,
        // required super.likes,
      });



  factory CategoryModel.fromJson(Map<String, dynamic>? json) {
    return CategoryModel(
    title : json!['title'],
    image : json['image'],
    categoryId:json['categoryId'],
    categoryUid:json['categoryUid'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'categoryId':categoryId,
      'categoryUid':categoryUid,
    };
  }
  Category toEntity() {
    return Category(
      title:title,
      image:image,
      categoryId:categoryId,
      categoryUid:categoryUid
    );

  }

}
