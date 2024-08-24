// add_category.dart
import 'package:adsmanagement/core/vaild/vaild.dart';
import 'package:adsmanagement/features/ads/presention/widgets/form_widget.dart';
import 'package:adsmanagement/shared/bloc/appbloc.dart';
import 'package:adsmanagement/shared/bloc/appstatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class AddCategory extends StatelessWidget {
 final  formKey = GlobalKey<FormState>();
 final  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppAddCategorySuccessState) {
          titleController.text = '';
          AppBloc.get(context).categoryImage = null;
        }
      },
      builder: (context, state) {
        var cubit = AppBloc.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Add Category'),
            centerTitle: true,
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
                            'Add Category',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          FormWidget(
                            controller: titleController,
                            inputType: TextInputType.name,
                            prefix: IconlyLight.info_circle,
                            validator: (val) {
                              return validInput(val: val!, min: 3, max: 25);
                            }, label: 'Category name',
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cubit.getCategoryImage();
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
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! AppAddCategoryLoadingState,
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
                                      if (formKey.currentState!.validate() &&
                                          cubit.categoryImage != null) {
                                        cubit.addCategory(
                                          name: titleController.text,
                                          imagePath: cubit.categoryImage!.path,
                                        );
                                      } else {
                                        print('Please select an image.');
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
                              ),
                            ),
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
