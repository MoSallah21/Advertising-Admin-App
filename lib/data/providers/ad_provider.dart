import 'package:adsmanagement/data/repositories/ad_repository.dart';
import 'package:adsmanagement/models/ads/ads.dart';
import 'dart:io';

class AdProvider {
  final AdRepository _repository;

  AdProvider(this._repository);

  // Get ads
  Stream<List<AdModel>> getAds() {
    return _repository.getAds();
  }

  // Add ad
  Future<void> addAd(AdModel model, File image) {
    return _repository.addAd(model, image);
  }

  // Delete ad
  Future<void> deleteAd(String? adId) {
    return _repository.deleteAd(adId);
  }
}
