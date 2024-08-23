import 'package:adphotos/core/componants/components.dart';
import 'package:adphotos/features/ads/domain/entities/ad.dart';
import 'package:adphotos/features/ads/presention/pages/view.dart';
import 'package:adphotos/features/ads/presention/bloc/ad_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:open_share_pro/open.dart';

class DetailsPage extends StatelessWidget {
final  Ad adModel;

  DetailsPage(this.adModel);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdBloc,AdState>(
      builder: (BuildContext context, AdState state) {
        final AdBloc bloc = BlocProvider.of<AdBloc>(context);
        String dateString = adModel.startDate!;
        DateTime dateTime = DateTime.parse(dateString);
        String formattedDate = intl.DateFormat('yyyy-MM-dd').format(dateTime);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor('#5A5A5A'),
            centerTitle: true,
            title: const Text(
              'Details',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            actions: [
              Icon(Icons.info_outlined,color: Colors.white,),
              SizedBox(width: 10,),

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      height: 420,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: GestureDetector(
                        onDoubleTap: (){
                          navigateTo(context, ViewImagePage(adModel.image!));
                        },
                        child: Image(
                            image: NetworkImage(adModel.image!)),
                      )
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  if(adModel.vip!)
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        Icon(Icons.star,color: Colors.yellow,),
                      ],
                    ),
                  if(adModel.vip!)
                    SizedBox(height: 8,),
                  Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Icon(IconlyLight.document,color: Colors.black,),
                      SizedBox(
                        width: 4,
                      ),
                      const Text('Name of place :',style: TextStyle(color: Colors.black),),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                          child: Text(
                            '${adModel.shopName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Icon(IconlyLight.category,color: Colors.black,),
                      SizedBox(
                        width: 4,
                      ),
                      const Text('Ad type :',style: TextStyle(color: Colors.black),),
                      SizedBox(
                        width: 4,
                      ),
                      Text('${adModel.catName}',style: TextStyle(color: Colors.black),),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Icon(IconlyLight.call,color: Colors.black,),
                      SizedBox(
                        width: 4,
                      ),
                      const Text('Phone :',style: TextStyle(color: Colors.black),),
                      SizedBox(
                        width: 4,
                      ),
                      TextButton(child: Text('${adModel.userNum}'),onPressed: (){
                        Open.whatsApp(whatsAppNumber: "+963991789422", text: "Hey i seen your the ad on AdApp");
                      },),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Icon(IconlyLight.time_circle,color: Colors.black,),
                      SizedBox(
                        width: 4,
                      ),
                      const Text('Date added :',style: TextStyle(color: Colors.black),),
                      SizedBox(
                        width: 4,
                      ),
                      Text('$formattedDate',style: TextStyle(color: Colors.black),),
                    ],
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
