import 'package:favourite_flutter/view/bottomNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/colorResources.dart';
import '../../widgets/AppText.dart';
import '../../widgets/customTextButton.dart';
import '../../widgets/custom_textfield.dart';

final _auth = FirebaseAuth.instance;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;
  String? password;

  void toastMessage(message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: ColorResource.blackColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AppText(
            title: 'Register',
            textSize: 40.0,
            textFontWeight: FontWeight.w700,
            textColor: ColorResource.lightBlackColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CustomTextfield(
                  hintText: 'Email',
                  fieldValueChanged: (value) {
                    // print(value);
                    email = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  hintText: 'Password',
                  passorText: true,
                  fieldValueChanged: (value) {
                    // print(value);
                    password = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextButton(
                  btnTitle: 'Register',
                  btnTextSize: 17,
                  btnBackgroundColor: ColorResource.lightBlackColor,
                  btnTextColor: ColorResource.whiteColor,
                  btnPadding:
                      EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                  pressed: () async {
                    print(email);
                    print(password);
                    try {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: email.toString().trim(),
                          password: password.toString().trim());
                      if (user != null) {
                        toastMessage('User Register successflly');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavigator()));
                      }
                    } catch (error) {
                      toastMessage(error.toString());
                      print(error.toString());
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomTextButton(
                      btnTitle: 'Already have account',
                      btnTextColor: ColorResource.blackColor,
                      pressed: () {
                        Navigator.pop(context);
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
