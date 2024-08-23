import 'package:adphotos/core/errors/exception.dart';
import 'package:adphotos/core/errors/failures.dart';
import 'package:adphotos/core/network/local/remot/network_info.dart';
import 'package:adphotos/features/ads/data/datasource/local/ad_local_datasource.dart';
import 'package:adphotos/features/ads/data/datasource/remote/ad_remote_datasource.dart';
import 'package:adphotos/features/ads/data/models/ad.dart';
import 'package:adphotos/features/ads/domain/entities/ad.dart';
import 'package:adphotos/features/ads/domain/repositories/ad_repository.dart';
import 'package:dartz/dartz.dart';
typedef Future<Unit> AutoDeleteAdOrUpdateLikes();


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
  Future<Either<Failure, Unit>> autoDeleteAd(String adId, String endDate) async{
    return await _getMessage(() => remoteDatasource.autoDeleteAd(adId,endDate));
  }

  // @override
  // Future<Either<Failure, Unit>> updateLike(Ad model, String adId)async {
  //   return await _getMessage(() => remoteDatasource.updateLike(model,adId));
  // }


  Future<Either<Failure, Unit>> _getMessage(
      AutoDeleteAdOrUpdateLikes autoDeleteAdOrUpdateLikes) async {
      try {
        await autoDeleteAdOrUpdateLikes();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
