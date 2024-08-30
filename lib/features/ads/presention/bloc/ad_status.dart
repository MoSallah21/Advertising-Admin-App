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


class AppChangeSelectedRadioState extends AdState{}

class AppChangeDropDownState extends AdState{}
// add Ad
class AddDeleteAdLoadingState  extends AdState{}

class AddDeleteAdSuccessState  extends AdState{
  final String message;

  AddDeleteAdSuccessState({required this.message});
}

class AddDeleteAdErrorState  extends AdState{
  final String message;

  AddDeleteAdErrorState({required this.message});
}

//pickAdPhoto
class AppPickedPhotoSuccessState  extends AdState{}

class AppPickedPhotoErrorState  extends AdState{}
//pickCatPhoto

class AppCategoryPickedPhotoSuccessState  extends AdState{}

class AppCategoryPickedPhotoErrorState  extends AdState{}

class RestTimePicker  extends AdState{}

class AppChangeSortState  extends AdState{}

class SetTimePicker  extends AdState{}

//notification
class NotificationSuccessStatus extends AdState{}

class NotificationLoadingStatus extends AdState{}

class NotificationErrorStatus extends AdState{}
//vip
class ChangeVip extends AdState{}
