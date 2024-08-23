import 'package:adphotos/core/componants/components.dart';
import 'package:adphotos/features/ads/domain/entities/ad.dart';
import 'package:adphotos/features/ads/presention/bloc/ad_bloc.dart';
import 'package:adphotos/features/ads/presention/pages/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';

class AdsPage extends StatelessWidget {
final  int index;
final  String catName;
AdsPage({required this.index,required this.catName});
final  Color likeColor=Colors.white;
final  IconData likeIcon=IconlyLight.heart;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdBloc,AdState>(
        builder:(BuildContext context,AdState state)
    {
      final AdBloc bloc = BlocProvider.of<AdBloc>(context);

      return Scaffold(
        backgroundColor: HexColor('#5A5A5A'),
        appBar: AppBar(
          backgroundColor: HexColor('#5A5A5A'),
          elevation: 0,
          title: Text('Advertisements',style: TextStyle(color: Colors.white),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          // actions: [
          //   PullDownButton(
          //     applyOpacity: true,
          //     routeTheme: PullDownMenuRouteTheme(width: 150),
          //     itemBuilder: (context) => [
          //       PullDownMenuItem.selectable(
          //         title: 'Latest',
          //         selected: cubit.selectIndex==0 ? true:false,
          //         onTap: () {
          //           cubit.selectIndex=0;
          //           cubit.emit(AppChangeFilter());
          //
          //         },
          //       ),
          //       const PullDownMenuDivider(),
          //       PullDownMenuItem.selectable(
          //         title: 'Older',
          //         selected: cubit.selectIndex==1 ? true:false,
          //         onTap: () {
          //           cubit.selectIndex=1;
          //           cubit.emit(AppChangeFilter());
          //         },
          //       ),
          //       const PullDownMenuDivider(),
          //       PullDownMenuItem.selectable(
          //         title: 'Most likes',
          //         selected: cubit.selectIndex==2 ? true:false,
          //         onTap: () {
          //           cubit.selectIndex=2;
          //           cubit.emit(AppChangeFilter());
          //         },
          //       ),
          //     ],
          //     position: PullDownMenuPosition.under,
          //     buttonBuilder: (context, showMenu) => CupertinoButton(
          //       onPressed: showMenu,
          //       padding: EdgeInsets.zero,
          //       child: const Icon(Icons.sort,color: Colors.white,),
          //     ),
          //   ),
          // ],
        ),
        body: StreamBuilder<List<Ad>>(
          stream: bloc.adsStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<Ad>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: HexColor('#69A88D'),
                ),
              );

            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );

            } else if (!snapshot.hasData) {
              return Center(
                child: Text('No data'),
              );
            } else {
              List<Ad> ads = snapshot.data!;
              // if(cubit.selectIndex==1){
              //   ads.sort((a, b) => a.startDate!.compareTo(b.startDate!));
              // }
              // if(cubit.selectIndex==2){
              //   ads.sort((a, b) => b.likes!.length.compareTo(a.likes!.length));
              // }
              // else if(cubit.selectIndex==0) {
              //   ads.sort((a, b) => b.startDate!.compareTo(a.startDate!));
              // }

              return PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ads.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildAds( bloc, ads[index], context, ads,likeIcon,likeColor, index,);
                },
              );
            }
          },
        ),
      );

    });

  }

  Widget buildAds(AdBloc bloc,Ad model,context, List<Ad> ad,likeIcon,likeColor, int index) {
    return Builder(
      builder: (context) {
        // if(model.likes!.contains(bloc.currentUser!.uId)){
        //   likeColor=Colors.red;
        //   likeIcon=IconlyBold.heart;}
        return Column(
          children: [
            if(index!=0)
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.arrow_left,color: Colors.white,),
                Text("Scroll right",style: TextStyle(color:Colors.white ),),
              ],
            ),
            Expanded(
              flex:12,
              child: Container(
              child: Image(fit:BoxFit.cover,
                image: NetworkImage(model.image!),),
              ),
            ),
            if((index+1)!=ad.length)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Scroll left",style: TextStyle(color: Colors.white),),
                Icon(Icons.arrow_right,color: Colors.white,),
              ],
            ),
            Expanded(
                  flex:1,
                  child: Container(
                    color: HexColor('#5A5A5A'),
                    child:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          IconButton(onPressed: (){
                            navigateTo(context, DetailsPage(model));
                          }, icon: Icon(Icons.info_outlined,color: Colors.white,)),
                          Text('${ad.length}/${index+1}',style: TextStyle(color: Colors.white,fontSize: 18),),
                          // GestureDetector(
                          //   onTap: ()async{
                          //     if(model.likes!.contains(bloc.currentUser!.uId)){
                          //       model.likes!.remove(bloc.currentUser!.uId);
                          //     }
                          //     else{
                          //       model.likes!.add(bloc.currentUser!.uId!);
                          //     }
                          //     await bloc.updateLikes(model, model.adId!);
                          //   },
                          //   child: Row(
                          //     children: [
                          //       Icon(likeIcon,color: likeColor,),
                          //       SizedBox(width: 3,),
                          //       Text('${model.likes!.length-1}',style: TextStyle(color: Colors.white),),
                          //
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ) ,
                  ),
                )
          ],
        );
      }
    );

  }


}