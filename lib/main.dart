import 'package:adsmanagement/data/providers/ad_provider.dart';
import 'package:adsmanagement/data/repositories/ad_repository.dart';
import 'package:adsmanagement/data/services/ad_service.dart';
import 'package:adsmanagement/shared/bloc/appbloc.dart';
import 'package:adsmanagement/shared/constants/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  final adProvider = AdProvider();
  final adService = AdService(adProvider);
  final adRepository = AdRepository(adService);

  runApp( MyApp(adRepository: adRepository,
  ));
}

class MyApp extends StatelessWidget {

  final AdRepository adRepository;

  const MyApp({super.key, required this.adRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppBloc(adRepository),
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


