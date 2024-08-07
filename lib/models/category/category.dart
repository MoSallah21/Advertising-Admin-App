class CategoryModel {
  String? title;
  String? image;
  int? categoryId;
  String? categoryUid;
  CategoryModel({
    required this.title,
    required this.image,
    this.categoryId,
    this.categoryUid,
  }

      );
  CategoryModel.fromJson(Map<String, dynamic>? json) {
    title = json!['title'];
    image = json['image'];
    categoryId=json['categoryId'];
    categoryUid=json['categoryUid'];

  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'categoryId':categoryId,
      'categoryUid':categoryUid,
    };
  }
}
