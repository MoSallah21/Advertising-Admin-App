import 'package:adsmanagement/data/repositories/ad_repository.dart';
import 'package:adsmanagement/models/ads/ads.dart';
import 'dart:io';

class AdService {
  final AdRepository _adRepository;

  AdService(this._adRepository);

  // Get ads
  Stream<List<AdModel>> getAds() {
    return _adRepository.getAds();
  }

  // Add ad
  Future<void> addAd(AdModel model, File image) {
    return _adRepository.addAd(model, image);
  }

  // Delete ad
  Future<void> deleteAd(String? adId) {
    return _adRepository.deleteAd(adId);
  }
}
