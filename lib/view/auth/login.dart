import 'package:favourite_flutter/utils/colorResources.dart';
import 'package:favourite_flutter/view/auth/register.dart';
import 'package:favourite_flutter/view/bottomNavigator.dart';
import 'package:favourite_flutter/widgets/AppText.dart';
import 'package:favourite_flutter/widgets/customTextButton.dart';
import 'package:favourite_flutter/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String? email,password;
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
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AppText(
            title: 'Login',
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
                  fieldValueChanged: (value){
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
                  fieldValueChanged: (value){
                    // print(value);
                    password = value;
                    },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextButton(
                  btnTitle: 'Login',
                  btnTextSize: 17,
                  btnBackgroundColor: ColorResource.lightBlackColor,
                  btnTextColor: ColorResource.whiteColor,
                  btnPadding: EdgeInsets.symmetric(
                    horizontal: 130,
                    vertical: 20,
                  ),
                  pressed: () {
                    try{
                      final user = _auth.signInWithEmailAndPassword(email: email.toString().trim(), password: password.toString().trim());
                      if(user != null){
                        toastMessage('User Login Successfully');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigator()));
                      }
                    }catch(error){
                      toastMessage(error.toString());
                    }
                    print(email);
                    print(password);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomTextButton(
                      btnTitle: 'Create New Account',
                      btnTextColor: ColorResource.blackColor,
                      pressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
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
