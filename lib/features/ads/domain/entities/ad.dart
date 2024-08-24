import 'package:equatable/equatable.dart';

class Ad extends Equatable{
  String? adId;
final  String? userNum;
final  String? shopName;
final  String? startDate;
final  String? endDate;
final String? catName;
  String? image;
final  bool?vip;
// final  List<dynamic> likes;

  Ad({required this.adId, required this.userNum, required this.shopName, required this.startDate, required this.endDate, required this.catName, required this.image, required this.vip});
  @override
  List<Object?> get props => [adId,userNum,shopName,startDate,endDate,catName,image,vip];
}