import 'package:adsmanagement/core/bloc_observer.dart';
import 'package:adsmanagement/data/repositories/ad_repository.dart';
import 'package:adsmanagement/data/repositories/category_repository.dart';
import 'package:adsmanagement/data/services/ad_service.dart';
import 'package:adsmanagement/data/services/category_service.dart';
import 'package:adsmanagement/shared/bloc/appbloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final categoryRepository = CategoryRepository(firestore: firestore, storage: storage);
  final categoryService = CategoryService(repository: categoryRepository);
  final adRepository = AdRepository();
  final adService = AdService(adRepository);

  runApp( MyApp(adService: adService,
  ));
}

class MyApp extends StatelessWidget {

  final AdService adService;

  const MyApp({super.key, required this.adService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppBloc(adService),
      child: MaterialApp(
        theme: ThemeData(appBarTheme: AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 2,
        ),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}


