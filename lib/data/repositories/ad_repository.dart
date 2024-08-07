// ad_repository.dart
import 'package:adsmanagement/models/ads/ads.dart';
import 'package:adsmanagement/data/services/ad_service.dart';
import 'dart:io';

class AdRepository {
  final AdService _adService;

  AdRepository(this._adService);

  // Get ads
  Stream<List<AdModel>> getAds() {
    return _adService.getAds();
  }

  // Add ad
  Future<void> addAd(AdModel model, File image) {
    return _adService.addAd(model, image);
  }

  // Delete ad
  Future<void> deleteAd(String? adId) {
    return _adService.deleteAd(adId);
  }
}
