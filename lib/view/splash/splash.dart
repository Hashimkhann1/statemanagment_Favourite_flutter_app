import 'package:favourite_flutter/utils/colorResources.dart';
import 'package:favourite_flutter/view/auth/login.dart';
import 'package:favourite_flutter/view/bottomNavigator.dart';
import 'package:favourite_flutter/view/home.dart';
import 'package:favourite_flutter/widgets/AppText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _auth = FirebaseAuth.instance;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SplashTimer();
  }

  void SplashTimer() async {
     await Future.delayed(Duration(seconds: 3));
     print(_auth.currentUser);
     Navigator.push(context, MaterialPageRoute(builder: (context) => _auth.currentUser != null ? BottomNavigator() : Login()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(
        child: AppText(title: 'FAVOURITE APP',textSize: 37.0,textFontWeight: FontWeight.w700,textColor: ColorResource.lightBlackColor,),
      ),
    ));
  }
}
