import 'dart:convert';
import 'package:adsmanagement/core/errors/exception.dart';
import 'package:adsmanagement/features/cetegories/data/models/category.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
abstract class CategoryLocalDatasource{
  Future<List<CategoryModel>> getCachedCategories();
  Future<Unit>cacheCategories(List<CategoryModel> categoryModels);
}
const String CACHED_CATEGORIES="CACHED_CATEGORIES";

class CategoryLocalImpl implements CategoryLocalDatasource{
 final SharedPreferences sharedPreferences;
 CategoryLocalImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheCategories(List<CategoryModel> categoryModels) {
    List categoryModelsToJson = categoryModels
        .map<Map<String,dynamic>>
      ((categoryModels)
    =>categoryModels.toJson())
        .toList();
    sharedPreferences.setString(CACHED_CATEGORIES, json.encode(categoryModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<CategoryModel>> getCachedCategories() {
    final jsonString =sharedPreferences.getString(CACHED_CATEGORIES);
    if(jsonString!=null) {
     List decodeJsonData= json.decode(jsonString);
     List<CategoryModel> jsonToPostModels=decodeJsonData.map<CategoryModel>(
         (jsonPostModel)=>CategoryModel.fromJson(jsonPostModel)).toList();
     return Future.value(jsonToPostModels);
    }
    else{
      throw EmptyCacheException();
    }

  }
}