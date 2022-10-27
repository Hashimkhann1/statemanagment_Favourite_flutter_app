import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favourite_flutter/provider/my_favourite_provier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<MyFavouriteProvider>(context);
    // print(_auth.currentUser);
    // print(imageProvider.favouriteItems);
    // print(imageProvider.favouriteItems[1]['itemName']);
    // print(imageProvider.favouriteItems[2]['itemName']);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorResource.lightBlackColor,
              title: AppText(title: 'Favourite'),
            ),
            body: StreamBuilder(
              stream: _firestor
                  .collection('favouriteItemOf${_auth.currentUser?.email}')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  Center(
                      child: AppText(
                    title: 'Some Thing went wrong',
                  ));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'images/loading.gif',
                                  image: snapshot.data?.docs[index]
                                      .data()['itemImageUrl'],
                                  width: double.maxFinite,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                          title: snapshot.data?.docs[index]
                                              .data()['itemName']
                                              .toString(),
                                          textSize: 26,
                                          textFontWeight: FontWeight.w700,
                                          textColor:
                                              ColorResource.lightBlackColor,
                                        ),
                                        Icon(Icons.thumb_up , color: ColorResource.primaryColor,)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    AppText(
                                      title:
                                          'Rs ${snapshot.data?.docs[index].data()['ItemPrice']}',
                                      textColor: ColorResource.primaryColor,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }
                return Text('return');
              },
            )));
  }
}

// ????????
//
// imageProvider.favouriteItems != null ?
// Consumer<MyFavouriteProvider>(builder: (context , value , child){
// return  ListView.builder(
// itemCount: value.favouriteItems.length,
// itemBuilder: (context , index) {
// print('hashim khan');
// print(value.favouriteItems.contains(value.favouriteItems[index]['itemName']));
// return Card(
// elevation: 30,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// ClipRRect(
// borderRadius: BorderRadius.circular(5),
// child: FadeInImage.assetNetwork(
// placeholder: 'images/loading.gif',
// image: value.favouriteItems[index]['imageUrl'] != null ? value.favouriteItems[index]['imageUrl'] : 'https://t4.ftcdn.net/jpg/04/75/01/23/360_F_475012363_aNqXx8CrsoTfJP5KCf1rERd6G50K0hXw.jpg',
// width: double.maxFinite,
// height: MediaQuery.of(context).size.height * 0.4,
// fit: BoxFit.fill,
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// AppText(title: value.favouriteItems[index]['itemName'] != null ? value.favouriteItems[index]['itemName'].toString() : 'No Data'.toString(),textSize: 26,textFontWeight: FontWeight.w700,textColor: ColorResource.lightBlackColor,),
// value.favouriteItems.contains(value.favouriteItems[index]) ? Icon(Icons.thumb_up,color: ColorResource.primaryColor,) : Icon(Icons.thumb_up_outlined),
// ],
// ),
// SizedBox(height: 2,),
// AppText(title: 'Rs ${value.favouriteItems[index]['itemPrice'] != null ? value.favouriteItems[index]['itemPrice'] : 'No Data'}',textColor: ColorResource.primaryColor,)
// ],
// ),
// )
// ],
// ),
// );
// });
// }) : Text('No Data Found')
