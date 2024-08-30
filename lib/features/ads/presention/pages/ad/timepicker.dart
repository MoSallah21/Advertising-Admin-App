import 'package:adsmanagement/features/ads/presention/bloc/ad_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class TimePick extends StatelessWidget {
  const TimePick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AdBloc, AdState>(
      listener: (context, state) {

      },
      builder: (context, state) {
         AdBloc bloc = BlocProvider.of<AdBloc>(context);
        return Scaffold(
          appBar: AppBar(title: Text('Choose time'),centerTitle: true,),
          body: Column(
            children: [
              Container(
                height: 100,
                alignment: Alignment.center,
                child: Text(
                  '${cubit.selectedDate}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 48),
                child: TextButton(
                  onPressed: () {
                    cubit.selectedDate = DateTime.now();
                    cubit.emit(RestTimePicker());
                  },
                  child: Text(
                    "Day",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child: ScrollDatePicker(
                  scrollViewOptions: DatePickerScrollViewOptions(),
                  minimumDate: DateTime.now(),
                  maximumDate: DateTime(2040),
                  selectedDate: cubit.selectedDate,
                  locale: Locale('en'),
                  onDateTimeChanged: (DateTime value) {
                      cubit.selectedDate = value;
                      cubit.emit(SetTimePicker());
                  },
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: HexColor('#f0dad8'),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        cubit.selectedDate=DateTime.now().add(Duration(days: 1));
                        cubit.emit(RestTimePicker());
                      },
                      child: const Text(
                        'Rest',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                SizedBox(width: 40,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: HexColor('#f2f2eb'),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

              ],),
            ],
          ),
        );
      },
    );
  }
}
