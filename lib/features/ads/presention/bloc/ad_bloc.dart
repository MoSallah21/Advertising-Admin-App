import 'package:adphotos/core/errors/failures.dart';
import 'package:adphotos/core/strings/failures.dart';
import 'package:adphotos/features/ads/data/models/ad.dart';
import 'package:adphotos/features/ads/domain/entities/ad.dart';
import 'package:adphotos/features/ads/domain/usecases/get_all_ads.dart';
import 'package:adphotos/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'ad_event.dart';
part 'ad_status.dart';

class AdBloc extends Bloc<AdEvent,AdState>{
  Users? currentUser;
  final GetAllAdsUseCase getAllAds;
  // final UpdateLikesUseCase updateLikes;

  AdBloc({required this.getAllAds}):super(AdsInitState()) {
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
      // else if(event is UpdateLikesEvent){
      //   await updateLikes.call(event.adModel, event.adId);
      //   emit(AdsLikeSuccessState());
      // }
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


// Future<void> updateLike(AdModel model, String adId) async {
//   try {
//     // Use AdService to update like count and return the result
//      await _adService.updateLike(model, adId);
//   } catch (e) {
//   }
// }
//
//
// void deleteAd(String adId, String endDate) {
//   _adService.deleteAd(adId, endDate);
// }
//
// void launchWhatsApp({required String phone, required String title}) async {
//   Open.whatsApp(whatsAppNumber: phone, text: title);
// }