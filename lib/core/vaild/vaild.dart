import 'package:adsmanagement/core/strings/messages.dart';

validInput({ required String val, required int min, required int max}){
  if(val.isEmpty)
    return "$messageEmpty";
if(val.length>max)
  return "$messageMax $max";
 if(val.length<min)
  return "$messageMin $min";


}