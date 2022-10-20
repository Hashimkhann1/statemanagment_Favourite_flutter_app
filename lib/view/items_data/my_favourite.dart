import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/colorResources.dart';
import '../../widgets/AppText.dart';

final _firestor = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

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
      body: StreamBuilder(
        stream: _firestor.collection('${_auth.currentUser?.email}favouriteData').snapshots(),
        builder: (context , snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        else if(snapshot.hasError){
          Center(child: AppText(title: 'Some Thing went wrong',));
        }
        else if(snapshot.hasData){
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context , index) {
                return Card(
                  elevation: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: FadeInImage.assetNetwork(
                            placeholder: 'images/loading.png',
                            image: snapshot.data?.docs[index].data()['itemImageUrl'],
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
                                AppText(title: snapshot.data?.docs[index].data()['itemName'].toString(),textSize: 26,textFontWeight: FontWeight.w700,textColor: ColorResource.lightBlackColor,),
                                Icon(Icons.thumb_up_outlined)
                              ],
                            ),
                            SizedBox(height: 2,),
                            AppText(title: 'Rs ${snapshot.data?.docs[index].data()['ItemPrice']}',textColor: ColorResource.primaryColor,)
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        }
        return Text('return');
      },)
    ));
  }
}
