import 'package:adsmanagement/features/ads/domain/entities/ad.dart';

class AdModel extends Ad {
  AdModel(
      {
        required super.adId,
        required super.userNum,
        required super.shopName,
        required super.startDate,
        required super.endDate,
        required super.catName,
        required super.image,
        required super.vip,
        // required super.likes,
      });


  factory AdModel.fromJson(Map<String, dynamic>? json) {
    return AdModel(
    adId: json!['adId'],
    userNum : json['userNum'],
    shopName : json['shopName'],
    startDate : json['startDate'],
    endDate : json['endDate'],
    catName : json['catName'],
    image : json['image'],
    // likes:json['likes'],
    vip:json['vip'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'adId': adId,
      'userNum': userNum,
      'shopName':shopName,
      'startDate': startDate,
      'endDate': endDate,
      'catName': catName,
      'image': image,
      // 'likes':likes,
      'vip':vip
    };
  }
  Ad toEntity() {
    return Ad(
      adId: adId,
      userNum: userNum,
      shopName: shopName,
      startDate: startDate,
      endDate: endDate,
      catName: catName,
      image: image,
      vip: vip,
    );

  }
}
