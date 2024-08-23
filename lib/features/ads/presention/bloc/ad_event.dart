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

// class UpdateLikesEvent extends AdEvent{
//   final AdModel adModel;
//   final String adId;
//
//   UpdateLikesEvent({required this.adModel,required this.adId});
// }
//
// class AutoDeleteAdsEvent extends AdEvent {}
//
