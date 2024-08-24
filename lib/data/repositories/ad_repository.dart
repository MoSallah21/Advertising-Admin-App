import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class AdRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // Add ad
  Future<void> addAd(AdModel model, File image) async {
    final storageRef = firebase_storage.FirebaseStorage.instance.ref().child('ads/${Uri.file(image.path).pathSegments.last}');
    final uploadTask = await storageRef.putFile(image);
    final imageUrl = await uploadTask.ref.getDownloadURL();
    model.image = imageUrl;

    final adDoc = await _firestore.collection('ads').add(model.toJson());
    final adId = adDoc.id;
    model.adId = adId;
    await adDoc.update({'adId': adId});
  }

  // Delete ad
  Future<void> deleteAd(String? adId) async {
    await _firestore.collection('ads').doc(adId).delete();
  }
}
