


import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

final _firestore = FirebaseFirestore.instance;

class NetworData{

  Future getData() async{
    final data = await _firestore.collection('itemData').snapshots();
    return data;
  }
}