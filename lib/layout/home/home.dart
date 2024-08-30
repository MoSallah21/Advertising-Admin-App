import 'package:adsmanagement/core/componants/components.dart';
import 'package:adsmanagement/features/ads/presention/pages/ad/ad.dart';
import 'package:adsmanagement/features/ads/presention/pages/ad/delete_ad.dart';
import 'package:adsmanagement/moudels/send_notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        var cubit=AppBloc.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Administration',style: TextStyle(color: Colors.white),),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/gray.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,top: 8.0,bottom: 8.0),
                  child: Text('Activities',style: TextStyle(color: Colors.white),),
                ),
                Expanded(child: GridView.count(crossAxisCount: 2,
                  children: List.generate(
                    5, (index) {
                    return buildGrid(cubit, index, context);
                  }),
                  shrinkWrap: false,
                  physics: BouncingScrollPhysics(),)),
              ],
            ),
          ),
        );
      },
    );
  }
}
Widget buildGrid(AppBloc model,int index,context)=>Column(
    children: [
  InkWell(
    onTap: (){
      if(index==0){
        navigateTo(context, AddAdvertising());
      }
      if(index==1){
        navigateTo(context, DeleteScreen());
      }
      if(index==2){
        navigateTo(context, NotificationScreen());
      }
      if(index==3){
        navigateTo(context, AddCategory());
      }
      if(index==4){
        navigateTo(context, DeleteCat());
      }
      }
    , child: Container(
      height: MediaQuery.of(context).size.height/7.4,
      width: MediaQuery.of(context).size.width/2.150,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15) )),
      child: Center(
        child: model.cir[index],
      )
    ),
  ),
  InkWell(
    onTap: (){
      if(index==0){
        navigateTo(context, AddAdvertising());
      }
      if(index==1){
        navigateTo(context, DeleteScreen());
      }
      if(index==2){
        navigateTo(context, NotificationScreen());
      }
      if(index==3){
        navigateTo(context, AddCategory());
      }
      if(index==4){
        navigateTo(context, DeleteCat());
      }
      },
    child: Container(
        width: MediaQuery.of(context).size.width/2.150,
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(bottomLeft:Radius.circular(15),bottomRight:Radius.circular(15) )),
        child: Center(child: Text(model.gridTitles[index]))),
  )

]);
