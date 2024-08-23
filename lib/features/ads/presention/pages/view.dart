import 'package:adphotos/features/Ads/presention/bloc/ad_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

class ViewImagePage extends StatelessWidget {
final String img;
ViewImagePage(this.img);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdBloc,AdState>(
      builder: (context, state) {
        return Scaffold(
            body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/image/background2.jpg'),
             fit: BoxFit.cover,
         ),
            ),
            child: Container(
                child: PhotoView(
                  imageProvider: NetworkImage(img,
                  ),
                )
            ),

            ),

        );
      },
    );
  }
}