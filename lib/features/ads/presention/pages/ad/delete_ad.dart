import 'package:adsmanagement/core/componants/components.dart';
import 'package:adsmanagement/features/ads/data/models/ad.dart';
import 'package:adsmanagement/features/ads/presention/bloc/ad_bloc.dart';
import 'package:adsmanagement/layout/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart' as intl;
import 'package:iconly/iconly.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class DeleteScreen extends StatelessWidget {
   int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdBloc, AdState>(
      builder: (BuildContext context, state) {
        final AdBloc bloc = BlocProvider.of<AdBloc>(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: Text('Posts',style: TextStyle(color: Colors.white),),
            centerTitle: true,
            actions: [
              PullDownButton(
                applyOpacity: true,
                routeTheme: PullDownMenuRouteTheme(width: 150),
                itemBuilder: (context) => [
                  PullDownMenuItem.selectable(
                    title: 'Newer',
                    selected: selectedIndex==0 ? true:false,
                    onTap: () {
                      selectedIndex=0;
                      cubit.emit(AppChangeSortState());

                    },
                  ),
                  const PullDownMenuDivider(),
                  PullDownMenuItem.selectable(
                    title: 'Older',
                    selected: selectedIndex==1 ? true:false,
                    onTap: () {
                      selectedIndex=1;
                      cubit.emit(AppChangeSortState());
                    },
                  ),
                  const PullDownMenuDivider(),
                  PullDownMenuItem.selectable(
                    title: 'Most likes',
                    selected: selectedIndex==2 ? true:false,
                    onTap: () {
                      selectedIndex=2;
                      cubit.emit(AppChangeSortState());
                    },
                  ),
                ],
                position: PullDownMenuPosition.under,
                buttonBuilder: (context, showMenu) => CupertinoButton(
                  onPressed: showMenu,
                  padding: EdgeInsets.zero,
                  child: const Icon(Icons.sort,color: Colors.white,),
                ),
              ),

            ],
          ),
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/gray.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: StreamBuilder<List<AdModel>>(
              stream: cubit.getAds(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<AdModel>> snapshot) {
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
                  List<AdModel> adModel = snapshot.data!;
                  if(selectedIndex==1){
                    adModel.sort((a, b) => a.startDate!.compareTo(b.startDate!));
                  }
                  // if(selectedIndex==2){
                  //   adModel.sort((a, b) => b.likes.length.compareTo(a.likes.length));
                  // }
                  else if(selectedIndex==0) {
                    adModel.sort((a, b) => b.startDate!.compareTo(a.startDate!));
                  }
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          buildDeleteItem(cubit, adModel[index], context),
                      itemCount: adModel.length,
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

Widget buildDeleteItem(AppBloc cubit, AdModel model,BuildContext context) =>
    Builder(

      builder: (context) {
        String dateString = model.startDate!;
        DateTime dateTime = DateTime.parse(dateString);
        String formattedDate = intl.DateFormat('yyyy-MM-dd').format(dateTime);
        return Container(
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            onTap: () {
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 20,
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.shopName}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              IconlyLight.category,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${model.catName} ',
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              IconlyLight.call,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${model.userNum}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              IconlyLight.heart,
                              size: 12,
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            // Text(
                            //   '${model.likes.length-1}',
                            //   style: Theme.of(context).textTheme.bodyMedium,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Icon(
                              IconlyLight.time_square,
                              size: 12,
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              '${formattedDate}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: InkWell(
                            onTap: () {
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "Delete post",
                                desc: "Are you sure ?",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      cubit.deleteAd(model.adId);
                                      navigateAndFinish(context, HomeScreen());
                                    },
                                    width: 120,
                                    color: HexColor('#69A88D'),
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                    color: HexColor('#69A88D'),
                                  ),
                                ],
                              ).show();
                            },
                            child: Row(
                              children: [
                                Text('Delete post'),
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  IconlyLight.delete,
                                  color: HexColor('#69A88D'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                    Expanded(
                      child: Container(
                        width: 130,
                        height: 150,
                        alignment: Alignment.topLeft,
                        child: Image.network(
                          '${model.image}',
                          width: 130,
                          height: 150,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }
    );
