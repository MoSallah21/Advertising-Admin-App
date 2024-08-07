// ad_service.dart
import 'package:adsmanagement/models/ads/ads.dart';
import 'package:adsmanagement/data/providers/ad_provider.dart';
import 'dart:io';

class AdService {
  final AdProvider _adProvider;

  AdService(this._adProvider);

  // Get ads
  Stream<List<AdModel>> getAds() {
    return _adProvider.getAds();
  }

  // Add ad
  Future<void> addAd(AdModel model, File image) {
    return _adProvider.addAd(model, image);
  }

  // Delete ad
  Future<void> deleteAd(String? adId) {
    return _adProvider.deleteAd(adId);
  }
}
