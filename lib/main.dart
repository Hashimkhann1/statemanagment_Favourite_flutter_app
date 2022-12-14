import 'package:favourite_flutter/provider/bottomNavigatorProvider.dart';
import 'package:favourite_flutter/provider/getGalleryImageProvider.dart';
import 'package:favourite_flutter/provider/my_favourite_provier.dart';
import 'package:favourite_flutter/view/auth/login.dart';
import 'package:favourite_flutter/view/bottomNavigator.dart';
import 'package:favourite_flutter/view/home.dart';
import 'package:favourite_flutter/view/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (_) => BottomNavigatorProvider()),
        ChangeNotifierProvider(create: (_) => GalleryImagePickerProvider()),
        ChangeNotifierProvider(create: (_) => MyFavouriteProvider())
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: BottomNavigator(),
        home: SplashScreen(),
    )
    );

  }
}

