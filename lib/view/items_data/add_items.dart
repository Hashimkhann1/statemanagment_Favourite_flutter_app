import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favourite_flutter/provider/getGalleryImageProvider.dart';
import 'package:favourite_flutter/utils/colorResources.dart';
import 'package:favourite_flutter/view/home.dart';
import 'package:favourite_flutter/widgets/AppText.dart';
import 'package:favourite_flutter/widgets/customTextButton.dart';
import 'package:favourite_flutter/widgets/custom_textfield.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class AddItems extends StatefulWidget {
  const AddItems({Key? key}) : super(key: key);

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {

  String? itemName;
  String? itemPrice;

  Future uploadImage(_image) async {
    String? url;
    String randomNumForImageName =
        DateTime.now().microsecondsSinceEpoch.toString();
    Reference refference =
        FirebaseStorage.instance.ref().child('imgaeId$randomNumForImageName');
    await refference.putFile(_image);
    url = await refference.getDownloadURL();
    return url;
  }

  void addDataToDatabase(BuildContext context) async {
    final imageProvider = Provider.of<GalleryImagePickerProvider>(context,listen: false);
    try{
      final imageurl = await uploadImage(imageProvider.image);
      await _firestore.collection('itemData').add({
        'itemName' : itemName,
        'itemPrice' : itemPrice,
        'imageUrl' : imageurl,
      });
      toastMessage('Item added Successfullly');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }catch(error){
      print('error while uploading data to DataBase $error');
    }
  }
  
  void toastMessage(message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: ColorResource.blackColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    final getImageProvider =
        Provider.of<GalleryImagePickerProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: AppText(title: 'Favourite'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  getImageProvider.getImage();
                },
                child: Consumer<GalleryImagePickerProvider>(
                    builder: (context, value, child) {
                  return value.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            value.image!.absolute,
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.height * 0.4,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: ColorResource.lightGrayColor,
                              borderRadius: BorderRadius.circular(6)),
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height * 0.43,
                          child: Icon(Icons.camera_alt),
                        );
                }),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                hintText: 'Item Name',
                icon: Icon(Icons.add_box),
                fieldValueChanged: (value) {
                  itemName = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                hintText: 'Item Price',
                icon: Icon(Icons.add_box),
                fieldValueChanged: (value) {
                  itemPrice = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextButton(
                btnTitle: 'Add Item',
                btnBackgroundColor: ColorResource.primaryColor,
                btnPadding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                btnTextColor: ColorResource.whiteColor,
                btnTextSize: 17.0,
                pressed: () {
                 addDataToDatabase(context);
                },
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
