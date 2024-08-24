import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FormWidget extends StatelessWidget {
  final String?text;
  final TextEditingController controller;
  final TextInputType inputType;
  final IconData prefix;
  final String label;
  final IconData? suffix;
  final void Function()? suffixPressed;
  final Function(String)? onsub;
  final bool? textShow;
  final String ?Function(String?)? validator;


  FormWidget(
      {this.text,
      required this.controller,
      required this.inputType,
      required this.prefix,
      required this.label,
      this.suffix,
      this.suffixPressed,
      this.onsub,
      this.textShow,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      cursorColor: Colors.white,
      controller:controller ,
      onFieldSubmitted:onsub ,
      keyboardType:inputType,
      style: TextStyle(color: Colors.white),
      obscureText: textShow??false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor('#ffffff')),
        ),
        prefixIcon: Icon(prefix,color: HexColor('#ffffff'),size:20.0),
        labelText: label,
        prefixText: text,
        labelStyle: TextStyle(color: HexColor('#ffffff')),
        suffixIcon: IconButton(
            icon:Icon(suffix,color: Colors.white,)
            ,onPressed:suffixPressed),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),

    );

  }
}
