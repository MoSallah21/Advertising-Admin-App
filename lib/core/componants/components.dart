import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';



Widget myDivider() {
  return Container(
    height: 1.0,
    width: double.infinity,
    color: Colors.grey[300],
  );
}
// List<ColorFilter> filters = [
//   ColorFilter.mode(Colors.transparent, BlendMode.saturation),
//   ColorFilter.mode(Colors.grey, BlendMode.saturation),
//   ColorFilter.mode(Colors.orange, BlendMode.softLight),
//   ColorFilter.mode(Colors.green, BlendMode.softLight),
//   ColorFilter.matrix(<double>[
//     0.33, 0.33, 0.33, 0, 0,
//     0.33, 0.33, 0.33, 0, 0,
//     0.33, 0.33, 0.33, 0, 0,
//     0, 0, 0, 1, 0,
//   ]),
//   ColorFilter.matrix(<double>[
//     0.64, 0.32, 0.0, 0.0, -0.01,
//     0.0, 0.67, 0.03, 0.0, 0.02,
//     0.0, 0.0, 0.72, 0.0, 0.02,
//     0.0, 0.0, 0.0, 1.0, 0.0,
//   ]),
//   ColorFilter.matrix(<double>[
//     1.0, 0.0, 0.0, 0.0, -65.0,
//     0.0, 1.0, 0.0, 0.0, -15.0,
//     0.0, 0.0, 1.0, 0.0, 35.0,
//     0.0, 0.0, 0.0, 1.0, 0.0,
//   ]),
// ];


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


