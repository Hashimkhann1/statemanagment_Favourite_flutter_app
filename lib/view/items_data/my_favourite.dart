import 'package:flutter/material.dart';

import '../../utils/colorResources.dart';
import '../../widgets/AppText.dart';

class MyFavourite extends StatefulWidget {
  const MyFavourite({Key? key}) : super(key: key);

  @override
  State<MyFavourite> createState() => _MyFavouriteState();
}

class _MyFavouriteState extends State<MyFavourite> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorResource.lightBlackColor,
            title: AppText(title: 'Favourite'),
          ),
      body: Column(
        children: [
          Card(
            elevation: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network('https://www.rd.com/wp-content/uploads/2020/04/GettyImages-471926619-scaled.jpg?fit=700,467',
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(title: 'Item Name',textSize: 26,textFontWeight: FontWeight.w700,textColor: ColorResource.lightBlackColor,),
                          Icon(Icons.thumb_up_outlined)
                        ],
                      ),
                      SizedBox(height: 2,),
                      AppText(title: 'Item Price',textColor: ColorResource.primaryColor,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
