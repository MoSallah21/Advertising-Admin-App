import 'dart:convert';

import 'package:adsmanagement/core/errors/exception.dart';
import 'package:adsmanagement/features/ads/data/models/ad.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
abstract class AdLocalDatasource{
  Future<List<AdModel>> getCachedAds();
  Future<Unit>cacheAds(List<AdModel> adModels);
}
const String CACHED_ADS="CACHED_ADS";

class AdLocalDatasourceImpl implements AdLocalDatasource{
 final SharedPreferences sharedPreferences;
  AdLocalDatasourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheAds(List<AdModel> adModels) {
    List adModelsToJson = adModels
        .map<Map<String,dynamic>>
      ((postModels)
    =>postModels.toJson())
        .toList();
    sharedPreferences.setString(CACHED_ADS, json.encode(adModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<AdModel>> getCachedAds() {
    final jsonString =sharedPreferences.getString(CACHED_ADS);
    if(jsonString!=null) {
     List decodeJsonData= json.decode(jsonString);
     List<AdModel> jsonToPostModels=decodeJsonData.map<AdModel>(
         (jsonPostModel)=>AdModel.fromJson(jsonPostModel)).toList();
     return Future.value(jsonToPostModels);
    }
    else{
      throw EmptyCacheException();
    }

  }
}