import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favourite_flutter/provider/my_favourite_provier.dart';
import 'package:favourite_flutter/utils/colorResources.dart';
import 'package:favourite_flutter/widgets/AppText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;

  void FavouriteDataToDatabase(String itemName,String itemPrice,String imageUrl,String itemId) async {
    await _firestore.collection('favouriteItemOf${_auth.currentUser?.email}').add({
      'itemId' : itemId,
      'itemName' : itemName,
      'ItemPrice' : itemPrice,
      'itemImageUrl' : imageUrl
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FavouriteItems();
  }
  



  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<MyFavouriteProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorResource.lightBlackColor,
          title: AppText(title: 'Favourite'),
        ),
        body: StreamBuilder(
          stream: _firestore.collection('itemData').snapshots(),
            builder: (context , snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasData){
              int? matchIndex;
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context , index){
                    // itemProvider.favouriteItems.forEach((element) {
                    //   if(element['itemName'] == snapshot.data?.docs[index].data()['itemName']){
                    //     matchIndex = index;
                    //     print(matchIndex);
                    //   }
                    // });
                    // var checkData = ;
                    Future FavouriteItems() async {
                      var favData = await _firestore.collection('favouriteItemOfhashimkhan@gmail.com').get();
                      favData.docs.forEach((element) {
                        print(element.data()['itemId']);
                        if(element.data()['itemId'] == snapshot.data!.docs[index].id){
                          matchIndex = index;
                          print(matchIndex);
                        }

                      });
                    };
                    FavouriteItems();
                    print('testing index $index');
                return Card(
                  elevation: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),

                        child: FadeInImage.assetNetwork(
                          placeholder: 'images/loading.gif',
                          image: snapshot.data?.docs[index].data()['imageUrl'],
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
                                AppText(title: snapshot.data!.docs[index].data()['itemName'].toString().length >= 13 ? snapshot.data?.docs[index].data()['itemName'].toString().substring(0,12) : snapshot.data?.docs[index].data()['itemName'].toString() ,textSize: 26,textFontWeight: FontWeight.w700,textColor: ColorResource.lightBlackColor,),
                                IconButton(onPressed: (){

                                  // itemProvider.addItem(snapshot.data?.docs[index].data()['itemName'], snapshot.data?.docs[index].data()['itemPrice'], snapshot.data?.docs[index].data()['imageUrl']);
                                  FavouriteDataToDatabase(snapshot.data?.docs[index].data()['itemName'], snapshot.data?.docs[index].data()['itemPrice'], snapshot.data?.docs[index].data()['imageUrl'], snapshot.data!.docs[index].id.toString());
                                }, icon: matchIndex == index ? Icon( Icons.thumb_up,color: ColorResource.primaryColor,) : Icon( Icons.thumb_up,color: ColorResource.lightGrayColor,)
                                )
                              ],
                            ),
                            SizedBox(height: 2,),
                            AppText(title: 'Rs ${snapshot.data?.docs[index].data()['itemPrice']}',textColor: ColorResource.primaryColor,)
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
            }
            else if(snapshot.hasError){
              return Text('error');
            }
          return Text('last return');
        })
      ),
    );
  }
}

