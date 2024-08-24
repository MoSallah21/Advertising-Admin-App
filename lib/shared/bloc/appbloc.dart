import 'dart:convert';
import 'package:adsmanagement/data/services/ad_service.dart';
import 'package:adsmanagement/data/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'appstatus.dart';
import 'dart:io';

class AppBloc extends Cubit<AppState> {
  final AdService _adService;
  final CategoryService _categoryService;

  AppBloc(this._adService,this._categoryService) : super(AppInitState());

  static AppBloc get(context) => BlocProvider.of(context);

  List<String> gridTitles = [
    'Add Advertisements', 'Delete Ad', 'Send notification', 'Add Category', 'Delete Category'
  ];

  List<Widget> cir = [
    CircleAvatar(
      radius: 40,
      child: Icon(Icons.add, size: 40),
    ),
    CircleAvatar(
      radius: 40,
      child: Icon(Icons.delete, size: 40),
    ),
    CircleAvatar(
      radius: 40,
      child: Icon(Icons.send, size: 40),
    ),
    CircleAvatar(
      radius: 40,
      child: Icon(Icons.add_box_sharp, size: 40),
    ),
    CircleAvatar(
      radius: 40,
      child: Icon(Icons.delete_outlined, size: 40),
    ),
  ];

  int selectedRadio = 0;
  void changeSelectedRadio(value) {
    selectedRadio = value;
    emit(AppChangeSelectedRadioState());
  }

  File? image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(AppPickedPhotoSuccessState());
    } else {
      emit(AppPickedPhotoErrorState());
    }
  }

  bool vip = false;
  void addAds({
    required String name,
    required String number,
    required String endDate,
    required String category,
  }) {
    emit(AppAddAdLoadingState());
    AdModel model = AdModel(
      shopName: name,
      userNum: number,
      catName: category,
      startDate: DateTime.now().toString(),
      endDate: endDate,
      vip: vip, image: '',
    );
    _adService.addAd(model, image!).then((_) {
      emit(AppAddAdSuccessState());
    }).catchError((onError) {
      emit(AppAddAdErrorState());
    });
  }

  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  Stream<List<AdModel>> getAds() {
    return _adService.getAds();
  }

  void deleteAd(String? postId) {
    _adService.deleteAd(postId).then((_) {
      emit(AppDeleteAdSuccessState());
    }).catchError((error) {
      emit(AppDeleteAdErrorState());
    });
  }

  dynamic serverToken = 'AAAAZN6HlaM:APA91bH7PFD81GLmIGOku-R4dlEITMcTyaQo3_UxCiY15yFkFvGCySplKZj67c2AWhp6AmzJIFDUs7KbJmN3oeKzgadYS1KA4ICcRSB-7oP5Mda5eZtThs2fomAJyGaylEi2pC_9vP-y';
  Future<void> sendNotification({
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) async {
    emit(NotificationLoadingStatus());
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': data,
          'to': "/topics/app",
        },
      ),
    ).then((value) async {
      emit(NotificationSuccessStatus());
      if (value.statusCode == 200) {
      } else {
        print(value.statusCode);
      }
    }).catchError((onError) {
      print(onError);
      emit(NotificationErrorStatus());
    });
  }

  File? categoryImage;
  final categoryPicker = ImagePicker();
  Future getCategoryImage() async {
    final pickedFile = await categoryPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      categoryImage = File(pickedFile.path);
      emit(AppCategoryPickedPhotoSuccessState());
    } else {
      emit(AppCategoryPickedPhotoErrorState());
    }
  }

  void addCategory({required String name, required String imagePath}) {
    emit(AppAddCategoryLoadingState());
    _categoryService.addCategory(name: name, imagePath: imagePath).then((_) {
      emit(AppAddCategorySuccessState());
    }).catchError((error) {
      emit(AppAddCategoryErrorState());
    });
  }

  void deleteCat(String? categoryUid) {
    _categoryService.deleteCategory(categoryUid).then((_) {
      emit(AppDeleteCatSuccessState());
    }).catchError((error) {
      emit(AppDeleteCatErrorState());
    });
  }
}
