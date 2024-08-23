import 'package:adphotos/core/errors/failures.dart';
import 'package:adphotos/features/ads/domain/entities/ad.dart';
import 'package:adphotos/features/ads/domain/repositories/ad_repository.dart';
import 'package:dartz/dartz.dart';


class GetAllAdsUseCase{
  final AdRepository repository;

  GetAllAdsUseCase(this.repository);

  Future<Either<Failure,List<Ad>>> call (String catName) async
  => await repository.getAllAds(catName);

}