import 'dart:io';
import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/features/ads/domain/entities/ad.dart';
import 'package:dartz/dartz.dart';

class AddAdtUseCase{
  final AdRepository repository;

  AddAdtUseCase(this.repository);
  Future<Either<Failure,Unit>> call(Ad ad,File image)async{
    return await repository.addAd(ad,image) ;

  }
}