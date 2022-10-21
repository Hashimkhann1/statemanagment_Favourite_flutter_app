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

  // void FavouriteDataToDatabase(String itemName,String itemPrice,String imageUrl) async {
  //   await _firestore.collection('${_auth.currentUser?.email}favouriteData').add({
  //     'itemName' : itemName,
  //     'ItemPrice' : itemPrice,
  //     'itemImageUrl' : imageUrl
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<MyFavouriteProvider>(context,listen: false);
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
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context , index){
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
                                  itemProvider.addItem(snapshot.data?.docs[index].data()['itemName'], snapshot.data?.docs[index].data()['itemPrice'], snapshot.data?.docs[index].data()['imageUrl']);
                                  // FavouriteDataToDatabase(snapshot.data?.docs[index].data()['itemName'], snapshot.data?.docs[index].data()['itemPrice'], snapshot.data?.docs[index].data()['imageUrl']);
                                }, icon:  Icon(Icons.thumb_up_outlined))
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

