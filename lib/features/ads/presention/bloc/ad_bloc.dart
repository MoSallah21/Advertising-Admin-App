import 'dart:io';

import 'package:adsmanagement/core/errors/failures.dart';
import 'package:adsmanagement/core/strings/failures.dart';
import 'package:adsmanagement/features/ads/domain/entities/ad.dart';
import 'package:adsmanagement/features/ads/domain/usecases/add_ad.dart';
import 'package:adsmanagement/features/ads/domain/usecases/delete_ad.dart';
import 'package:adsmanagement/features/ads/domain/usecases/get_all_ads.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'ad_event.dart';
part 'ad_status.dart';

class AdBloc extends Bloc<AdEvent,AdState>{
  final GetAllAdsUseCase getAllAds;
  final AddAdtUseCase addAd;
  final DeleteAdUseCase deleteAd;

  AdBloc({required this.getAllAds,required this.addAd,required this.deleteAd}):super(AdsInitState()) {
    on<AdEvent>((event,emit)async{
      if(event is GetAllAdsEvent){
        emit(GetAllAdsLoadingState());
        final failureOrPosts =await getAllAds.call(event.catName);
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
      else if(event is RefreshAdsEvent){
        emit(GetAllAdsLoadingState());
        final failureOrPosts =await getAllAds.call(event.catName);
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
      else if(event is AddAdEvent){
        emit(AddDeleteAdLoadingState());
        final failureOrSuccess=await addAd(event.ad,event.image);
        emit(_addOrDelete(failureOrSuccess,"Add category success"));
      }
      else if(event is DeleteAdEvent){
        emit(AddDeleteAdLoadingState());
        final failureOrSuccess=await deleteAd(event.adId);
        emit(_addOrDelete(failureOrSuccess,"Delete category success"));
      }
    });
  }
  Stream<List<Ad>> get adsStream async* {
    await for (final state in stream) {
      if (state is GetAllAdsSuccessState) {
        yield state.ads;
      }
    }
  }
  }
  AdState _mapFailureOrPostsToState(Either<Failure,List<Ad>> either)  {
    return either.fold(
          (failure)=>GetAllAdsErrorState(message: _mapFailureToMessage(failure)),
          (ads)=> GetAllAdsSuccessState(ads: ads),
    );
  }
  String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OffLineFailure:
        return OFF_LINE_FAILURE_MESSAGE;
      default: return "Unexpected error, please try again later";
    }
  }


AdState _addOrDelete(Either<Failure,Unit> either,message){
  return either.fold(
        (failure)=>AddDeleteAdErrorState(message: _mapFailureToMessage(failure)),
        (_)=> AddDeleteAdSuccessState(message:message ),
  );
}
