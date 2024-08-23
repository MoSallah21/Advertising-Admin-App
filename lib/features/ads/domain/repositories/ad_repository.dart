import 'package:adphotos/core/errors/failures.dart';
import 'package:adphotos/features/ads//domain/entities/ad.dart';
import 'package:dartz/dartz.dart';

abstract class AdRepository {
  Future<Either<Failure,List<Ad>>> getAllAds(String catName);

  // Future<Either<Failure,Unit>> updateLike(Ad model, String adId);

  Future<Either<Failure,Unit>> autoDeleteAd(String adId, String endDate);

}