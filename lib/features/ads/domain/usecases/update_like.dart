// import 'package:adphotos/core/errors/failures.dart';
// import 'package:adphotos/features/ads/domain/entities/ad.dart';
// import 'package:adphotos/features/ads/domain/repositories/ad_repository.dart';
// import 'package:dartz/dartz.dart';
//
//
// class UpdateLikesUseCase{
//   final AdRepository repository;
//
//   UpdateLikesUseCase(this.repository);
//   Future<Either<Failure,Unit>> call(Ad model, String adId)async{
//     return await repository.updateLike(model,adId);
//   }
// }