import 'package:adsmanagement/core/componants/components.dart';
import 'package:adsmanagement/features/ads/data/models/category.dart';
import 'package:adsmanagement/layout/home/home.dart';
import 'package:adsmanagement/shared/bloc/appbloc.dart';
import 'package:adsmanagement/shared/bloc/appstatus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class DeleteCat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var cubit = AppBloc.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: Text('Categories',style: TextStyle(color: Colors.white),),
            centerTitle: true,
            actions: [
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
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('categories').orderBy('categoryId', descending: false).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return Text('No data available');
                  }
                  List<CategoryModel> categories = snapshot.data!.docs.map((doc) => CategoryModel.fromJson(doc.data())).toList();
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            buildDeleteItem(cubit, categories[index], context),
                        itemCount: categories.length,
                      ),
                    );
                })

          ),
        );
      },
    );
  }
}

Widget buildDeleteItem(AppBloc cubit, CategoryModel model,BuildContext context) =>

           Container(
            width: double.infinity,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
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
                          '${model.title}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: InkWell(
                            onTap: () {
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "Delete category",
                                desc: "Are you sure ?",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      cubit.deleteCat(model.categoryUid);
                                      navigateAndFinish(context, HomeScreen());
                                    },
                                    width: 120,
                                    color: Colors.grey,
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                    color: Colors.grey,
                                  ),
                                ],
                              ).show();
                            },
                            child: Row(
                              children: [
                                Text('Delete category'),
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
          );

