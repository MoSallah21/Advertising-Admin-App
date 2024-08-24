import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/features/ads/domain/repositories/ad_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAdUseCase{
  final AdRepository repository;

  DeleteAdUseCase(this.repository);
  Future<Either<Failure,Unit>> call(String adId)async{
    return await repository.deleteAd(adId);
  }
}