import 'dart:io';
import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/features/ads/domain/entities/ad.dart';
import 'package:dartz/dartz.dart';

abstract class AdRepository {
  Future<Either<Failure,List<Ad>>> getAllAds(String catName);

  // Future<Either<Failure,Unit>> updateLike(Ad model, String adId);

  Future<Either<Failure,Unit>> deleteAd(String adId);
  Future<Either<Failure,Unit>> addAd(Ad model, File image);

}