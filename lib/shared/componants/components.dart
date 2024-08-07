import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';



Widget myDivider() {
  return Container(
    height: 1.0,
    width: double.infinity,
    color: Colors.grey[300],
  );
}


Widget defaultTextForm(
    {
      String? text,
      required TextEditingController controller,
      required TextInputType inputType,
      required IconData prefix,
      required String lable,
      IconData? suffix,
      void Function()? suffixPressed,
      Function(String)? onsub,
      bool textShow=false,
      final String ?Function(String?)? validator,
    }
    )
{
  return TextFormField(
    validator: validator,
    cursorColor: Colors.black,
    controller:controller ,
    onFieldSubmitted:onsub ,
    keyboardType:inputType,
    style: TextStyle(color: Colors.black),
    obscureText: textShow,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: HexColor('#121212')),
      ),
      prefixIcon: Icon(prefix,color: HexColor('#121212'),size:20.0),
      labelText: lable,
      prefixText: text,
      labelStyle: TextStyle(color: HexColor('#121212')),
      suffixIcon: IconButton(
          icon:Icon(suffix,color: Colors.white,)
          ,onPressed:suffixPressed),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),

  );
}


Future navigateAndFinish(context, screen){
  return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen),(Route<dynamic> route) =>false);
}


Future navigateTo(context,Widget screen){
  return Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
void navigateToWithPush(context,screen){
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        );
      },
    ),
  );
}

void navigateToWithSlide(context,screen){
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ),
  );

}


