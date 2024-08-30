part of 'ad_bloc.dart';


abstract class AdEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class GetAllAdsEvent extends AdEvent{
  final String catName;

  GetAllAdsEvent({required this.catName});
}

class RefreshAdsEvent extends AdEvent{
  final String catName;

  RefreshAdsEvent({required this.catName});
}
class AddAdEvent extends AdEvent{
  final Ad ad;
  final File image;

  AddAdEvent({required this.ad,required this.image});

  @override
  List<Object?> get props => [ad];
}

class DeleteAdEvent extends AdEvent{
  final String adId;

  DeleteAdEvent({required this.adId});

  @override
  List<Object?> get props => [adId];
}


// class UpdateLikesEvent extends AdEvent{
//   final AdModel adModel;
//   final String adId;
//
//   UpdateLikesEvent({required this.adModel,required this.adId});
// }
//
// class AutoDeleteAdsEvent extends AdEvent {}
//
