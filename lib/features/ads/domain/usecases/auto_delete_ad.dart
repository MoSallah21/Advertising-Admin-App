import 'package:adphotos/core/errors/failures.dart';
import 'package:adphotos/features/ads/domain/repositories/ad_repository.dart';
import 'package:dartz/dartz.dart';

class AutoDeleteAdUseCase{
  final AdRepository repository;

  AutoDeleteAdUseCase(this.repository);
  Future<Either<Failure,Unit>> call(String adId,endDate)async{
    return await repository.autoDeleteAd(adId,endDate);
  }
}