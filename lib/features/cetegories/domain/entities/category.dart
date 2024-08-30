import 'package:equatable/equatable.dart';

class Category extends Equatable{
  final String? title;
  final String? image;
  final int? categoryId;
  final String? categoryUid;

  Category({required this.title, required this.image, required this.categoryId, required this.categoryUid});

  @override
  List<Object?> get props => [title,image,categoryId,categoryUid];
}