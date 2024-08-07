import 'dart:convert';
import 'package:adsmanagement/models/category/category.dart';
import 'package:http/http.dart'as http;
import 'package:adsmanagement/models/ads/ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firesbase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'appstatus.dart';
import 'dart:io';


class AppBloc extends Cubit<AppState> {
  AppBloc(): super(AppInitState());

  static AppBloc get(context) => BlocProvider.of(context);

  List<String> gridTitles=[
    'Add Advertisements','Delete Ad','Send notification','Add Category','Delete Category'
  ];

  List<Widget> cir=[
    CircleAvatar(
      radius: 40,
      child: Icon(Icons.add,size: 40,),
    ),
    CircleAvatar(
      radius: 40,
      child: Icon(Icons.delete,size: 40,),
    ),
    CircleAvatar(
      radius: 40,
      child: Icon(Icons.send,size: 40,),
    ),
    CircleAvatar(
      radius: 40,
      child: Icon(Icons.add_box_sharp,size: 40,),
    ),
    CircleAvatar(
      radius: 40,
      child: Icon(Icons.delete_outlined,size: 40,),
    ),


  ];

  int selectedRadio=0;
  void changeSelectedRadio(value){
    selectedRadio=value;
    emit(AppChangeSelectedRadioState());
  }
  File? image;
  final picker =ImagePicker();
  Future getImage() async {
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      image=File(pickedFile.path);
      emit(AppPickedPhotoSuccessState());
    }
    else{
      emit(AppPickedPhotoErrorState());
    }
  }
  bool vip=false;
  void addAds({
    required String name,
    required String number,
    required String endDate,
    required String category,
  }){
    if(!vip) {
      emit(AppAddAdLoadingState());
      firesbase_storage.FirebaseStorage.instance
          .ref()
          .child('ads/${Uri
          .file(image!.path)
          .pathSegments
          .last}')
          .putFile(image!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          AdModel model = AdModel(
            shopName: name,
            userNum: number,
            catName: category,
            startDate: DateTime.now().toString(),
            endDate: endDate,
            vip: false,
            image: value,
          );
          FirebaseFirestore.instance
              .collection('ads')
              .add(model.toMap())
              .then((DocumentReference documentRef) {
            String adId = documentRef.id;
            model.adId = adId;
            documentRef.update({'adId': adId});
            emit(AppAddAdSuccessState());
          }).catchError((error) {});
        });
      }).catchError((onError) {
        emit(AppAddAdErrorState());
      });
    }
    else{
      emit(AppAddAdLoadingState());
      firesbase_storage.FirebaseStorage.instance
          .ref()
          .child('ads/${Uri
          .file(image!.path)
          .pathSegments
          .last}')
          .putFile(image!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          AdModel model = AdModel(
            shopName: name,
            userNum: number,
            catName: category,
            startDate: DateTime.now().toString(),
            endDate: endDate,
            vip: true,
            image: value,
          );
          FirebaseFirestore.instance
              .collection('ads')
              .add(model.toMap())
              .then((DocumentReference documentRef) {
            String adId = documentRef.id;
            model.adId = adId;
            documentRef.update({'adId': adId});
            emit(AppAddAdSuccessState());
          }).catchError((error) {});
        });
      }).catchError((onError) {
        emit(AppAddAdErrorState());
      });

    }
  }
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  Stream<List<AdModel>> getAds() {
      return FirebaseFirestore.instance
          .collection('ads')
          .orderBy('startDate',descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => AdModel.fromJson(doc.data())).toList();
      });

  }
  void deleteAd(
      String? postId,
      ){
    FirebaseFirestore.instance
        .collection('ads')
        .doc(postId)
        .delete()
        .then((value) {
      emit(AppDeleteAdSuccessState());
    }).catchError((error){
      emit(AppDeleteAdErrorState());
    });
  }
  dynamic serverToken='AAAAZN6HlaM:APA91bH7PFD81GLmIGOku-R4dlEITMcTyaQo3_UxCiY15yFkFvGCySplKZj67c2AWhp6AmzJIFDUs7KbJmN3oeKzgadYS1KA4ICcRSB-7oP5Mda5eZtThs2fomAJyGaylEi2pC_9vP-y';
  Future<void> sendNotification({
    required String title,
    required String body,
    required Map<String,dynamic> data,
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
          'notification': <String, dynamic>{
            'body': body,
            'title': title
          },
          'priority': 'high',
          'data': data,
          'to': "/topics/app",
        },
      ),
    ).then((value) async {
      emit(NotificationSuccessStatus());

      if(value.statusCode==200){
      }else{
        print(value.statusCode);
      }
    }).catchError((onError){
      print(onError);
      emit(NotificationErrorStatus());
    });
  }

  File? categoryImage;
  final categoryPicker =ImagePicker();
  Future getCategoryImage() async {
    final pickedFile=await categoryPicker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      categoryImage=File(pickedFile.path);
      emit(AppCategoryPickedPhotoSuccessState());
    }
    else{
      emit(AppCategoryPickedPhotoErrorState());
    }
  }
  void addCategory({
    required String name,
  }) {
    emit(AppAddCategoryLoadingState());
    firesbase_storage.FirebaseStorage.instance
        .ref()
        .child('category/${Uri.file(categoryImage!.path).pathSegments.last}')
        .putFile(categoryImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        CategoryModel model = CategoryModel(
          title: name,
          image: value,
        );
        FirebaseFirestore.instance
            .collection('categories')
            .get()
            .then((QuerySnapshot snapshot) {
          int nextCategoryId = 1;
            if (snapshot.size > 0) {
              // Get the maximum categoryId from existing documents and increment it by 1
              int maxCategoryId = snapshot.docs
                  .map((doc) => doc['categoryId'])
                  .fold(0, (max, categoryId) => categoryId > max ? categoryId : max);
              nextCategoryId = maxCategoryId + 1;
            }
          model.categoryId = nextCategoryId;
          FirebaseFirestore.instance
              .collection('categories')
              .add(model.toMap())
              .then((DocumentReference documentRef) {
              documentRef.update({'categoryId': nextCategoryId});
              String catUid = documentRef.id;
              model.categoryUid = catUid;
              documentRef.update({'categoryUid': catUid});
            emit(AppAddCategorySuccessState());
          }).catchError((error) {});
        });
      });
    }).catchError((onError) {
      emit(AppAddCategoryErrorState());
    });
  }
  void deleteCat(
      String? cattUid,
      ){
    FirebaseFirestore.instance
        .collection('categories')
        .doc(cattUid)
        .delete()
        .then((value) {
      emit(AppDeleteCatSuccessState());
    }).catchError((error){
      emit(AppDeleteCatErrorState());
    });
  }
}
