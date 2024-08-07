class AdModel {
  String? adId;
  String? userNum;
  String? shopName;
  String? startDate;
  String? endDate;
  String? catName;
  String? image;
  bool?vip;
  List<dynamic> likes=[""];
  AdModel({
    this.adId,
    required this.userNum,
    required this.shopName,
    required this.startDate,
    required this.endDate,
    required this.catName,
    required this.image,
    required this.vip,
  }

  );
  AdModel.fromJson(Map<String, dynamic>? json) {
    adId = json!['adId'];
    userNum = json['userNum'];
    shopName = json['shopName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    catName = json['catName'];
    image = json['image'];
    likes=json['likes'];
    vip=json['vip'];

  }
  Map<String, dynamic> toMap() {
    return {
      'adId': adId,
      'userNum': userNum,
      'shopName':shopName,
      'startDate': startDate,
      'endDate': endDate,
      'catName': catName,
      'image': image,
      'likes':likes,
      'vip':vip
    };
  }
}
