
import 'dart:io';

import 'package:adsmanagement/core/errors/exception.dart';
import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/core/network/local/remot/network_info.dart';
import 'package:adsmanagement/features/ads/data/datasource/local/ad_local_datasource.dart';
import 'package:adsmanagement/features/ads/data/datasource/remote/ad_remote_datasource.dart';
import 'package:adsmanagement/features/ads/data/models/ad.dart';
import 'package:adsmanagement/features/ads/domain/entities/ad.dart';
import 'package:adsmanagement/features/ads/domain/repositories/ad_repository.dart';
import 'package:dartz/dartz.dart';
typedef Future<Unit> DeleteOrAddOr();


class AdRepositoryImpl implements AdRepository{
  final AdRemoteDatasource remoteDatasource;
  final AdLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  AdRepositoryImpl({required this.remoteDatasource, required this.localDatasource, required this.networkInfo});
  @override
  Future<Either<Failure, List<Ad>>> getAllAds(String catName)async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAds = await remoteDatasource.getAllAds(catName);
        localDatasource.cacheAds(remoteAds);
        return Right(remoteAds);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localAds = await localDatasource.getCachedAds();
        return Right(localAds);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }  }

  @override
  Future<Either<Failure, Unit>> deleteAd(String adId) async{
    return await _getMessage(() => remoteDatasource.deleteAd(adId));
  }

  @override
  Future<Either<Failure, Unit>> addAd(Ad ad, File image)async {
    final AdModel adModel=AdModel(
      adId: ad.adId,
      userNum: ad.userNum,
      shopName: ad.shopName,
      startDate: ad.startDate,
      endDate: ad.endDate,
      catName: ad.catName,
      image: ad.image,
      vip: ad.vip,
    );
    return await _getMessage(() => remoteDatasource.addAd(adModel,image));
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


  }
