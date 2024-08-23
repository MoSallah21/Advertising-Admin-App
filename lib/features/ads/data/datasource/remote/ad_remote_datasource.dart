import 'package:adphotos/core/errors/exception.dart';
import 'package:adphotos/features/ads//data/models/ad.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class AdRemoteDatasource{
  Future<List<AdModel>> getAllAds(String catName);
  // Future<Unit> updateLike(AdModel model, String adId);
  Future<Unit> autoDeleteAd(String adId, String endDate);
}
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class AdRemoteDatasourceImpl implements AdRemoteDatasource{
  @override

  Future<List<AdModel>> getAllAds(String catName) async{
    try {
      final querySnapshot = await _firestore
          .collection('ads')
          .where('catName', isEqualTo: catName)
          .orderBy('startDate', descending: true)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => AdModel.fromJson(doc.data()))
            .toList();
      } else {
        throw Exception("No ads found for this category");
      }
    } catch (e) {
      throw ServerException();
    }
  }

  // @override
  // Future<Unit> updateLike(AdModel model, String adId)async {
  //   await _firestore.collection("ads").doc(adId).update(model.toJson());
  //   return Future.value(unit);
  //
  // }

  @override
  Future<Unit> autoDeleteAd(String adId, String endDate)async {
    final adsRef = _firestore.collection('ads');
    final adDoc = adsRef.doc(adId);
    if (DateTime.now().isAfter(DateTime.parse(endDate))) {
      await adDoc.delete();
      return Future.value(unit);
    }
    return Future.value(unit);

  }


}