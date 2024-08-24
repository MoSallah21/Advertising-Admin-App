import 'package:adsmanagement/core/componants/components.dart';
import 'package:adsmanagement/core/vaild/vaild.dart';
import 'package:adsmanagement/features/ads/presention/widgets/form_widget.dart';
import 'package:adsmanagement/shared/bloc/appbloc.dart';
import 'package:adsmanagement/shared/bloc/appstatus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';

import 'timepicker.dart';



class AddAdvertising extends StatelessWidget {
 final  formKey = GlobalKey<FormState>();
 final TextEditingController nameController = TextEditingController();
 final TextEditingController numController = TextEditingController();
  String value='Stores';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppAddAdSuccessState) {
          nameController.text='';
          numController.text='';
          AppBloc.get(context).selectedDate=DateTime.now().add(Duration(days: 1));
          value='Stores';
          AppBloc.get(context).image=null;
          AppBloc.get(context).vip=false;
        }
      },
      builder: (context, state) {
        var cubit=AppBloc.get(context);
        return Scaffold(
          appBar: AppBar(title: Text('Add Advertisements'),centerTitle: true,),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/gray.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add an advertisement',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        FormWidget(
                          controller: nameController,
                          inputType: TextInputType.name,
                          prefix: IconlyLight.info_circle,
                          label: 'Place name',
                          validator:(val){
                            return validInput(
                                val:val!,
                                min:3,
                                max:25);
                          } ,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FormWidget(
                          controller: numController,
                          inputType: TextInputType.phone,
                          prefix: Icons.phone,
                          label: 'Phone',
                          validator:(val){
                            return validInput(
                                val:val!,
                                min:10,
                                max:10);
                          } ,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              IconlyLight.category,
                              color: Colors.black
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Type',
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 2,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5,),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (!snapshot.hasData) {
                                  return Text('Loading...');
                                }
                                var categories = snapshot.data!.docs.map((doc) => doc['title']).toList();
                                return DropdownButton(
                                  value: value,
                                  items: categories.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    value = val as String;
                                    cubit.emit(AppChangeDropDownState());
                                  },
                                );
                              },
                            ),
                            SizedBox(width: 40,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Checkbox(
                                  checkColor: Colors.white,
                                    activeColor: Colors.grey,
                                    value: cubit.vip,
                                    onChanged: (bool? value){
                                      cubit.vip=value!;
                                      print(cubit.vip);
                                      cubit.emit(ChangeVip());
                                    }
                                    ),
                                SizedBox(width: 5,),
                                Text('هام'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  cubit.getImage();
                                },
                                child: Row(
                                  children: [
                                    const Text('Add photo'),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  navigateTo(context, TimePick());
                                },
                                child: Row(
                                  children: [
                                    const Text('Choose Date'),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Icon(
                                      Icons.lock_clock,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! AppAddAdLoadingState,
                          builder: (context) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: HexColor('#f2f2eb'),
                                ),
                                height: 50.0,
                                width: 300,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()
                                        &&cubit.image!=null
                                        ) {
                                      cubit.addAds(
                                          name: nameController.text,
                                          number: numController.text,
                                          endDate: cubit.selectedDate.toString(),
                                          category: value);
                                    }
                                  },
                                  child: const Text(
                                    'Add',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          fallback: (context) => Center(
                              child: CircularProgressIndicator(
                                color: HexColor('#69A88D'),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
