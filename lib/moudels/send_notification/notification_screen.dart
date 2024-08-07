import 'package:adsmanagement/shared/bloc/appbloc.dart';
import 'package:adsmanagement/shared/bloc/appstatus.dart';
import 'package:adsmanagement/shared/componants/components.dart';
import 'package:adsmanagement/shared/vaild/vaild.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';

class NotificationScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is NotificationSuccessStatus) {
          titleController.text='';
          contentController.text='';
        }
      },
      builder: (context, state) {
        var cubit=AppBloc.get(context);
        return Scaffold(
          appBar: AppBar(title: Text('Add notification'),centerTitle: true,),
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
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'اضف اشعار',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultTextForm(
                            controller: titleController,
                            inputType: TextInputType.name,
                            prefix: IconlyLight.info_circle,
                            lable: 'عنوان الاشعار',
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
                          defaultTextForm(
                            controller: contentController,
                            inputType: TextInputType.text,
                            prefix: Icons.newspaper,
                            lable: 'محتوى الاشعار',
                            validator:(val){
                              return validInput(
                                  val:val!,
                                  min:2,
                                  max:25);
                            } ,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! NotificationLoadingStatus,
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
                                      if (formKey.currentState!.validate()) {
                                        cubit.sendNotification(
                                            title: titleController.text,
                                            body: contentController.text,
                                            data:{'{info_id': '12345'}
                                        );


                                      }

                                    },
                                    child: const Text(
                                      'ارسال',
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}