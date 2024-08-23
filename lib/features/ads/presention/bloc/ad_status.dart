part of 'ad_bloc.dart';

abstract class AdState{}

class AdsInitState extends AdState{}

//scroll

class AdsScrollImage extends AdState{}

class AdsJumpImage extends AdState{}

class AdsToggleFilter extends AdState{}

class AdsChangeFilter extends AdState{}

//likes
// class AdsLikeSuccessState extends AdState{}
//
// class AdsLikeErrorState extends AdState{}
//
class GetAllAdsSuccessState extends AdState{
  final List<Ad> ads;

  GetAllAdsSuccessState({required this.ads});

}

class GetAllAdsErrorState extends AdState{
  final String message;

  GetAllAdsErrorState({required this.message});
}

class GetAllAdsLoadingState extends AdState{}




