import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Models/AppUser.dart';
import 'package:mobile_app/Widgets/AppButtons.dart';
import 'package:mobile_app/Widgets/AppColors.dart';
import 'package:mobile_app/Widgets/AppTextField.dart';

import 'Home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    TextEditingController publicController = new TextEditingController();
    TextEditingController privateController = new TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.gray,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight / 5),
            Image(
              width: screenWidth * .78,
              image: AssetImage("assets/logo.png")
            ),
            SizedBox(height: 30),
            AppTextField.getTextField(publicController, "Public Key", screenHeight, screenWidth),
            SizedBox(height: 20),
            AppTextField.getTextField(privateController, "Private Key", screenHeight, screenWidth),
            Spacer(),
            AppButtons.getButton(() {
              // TODO
              AppUser.publicKey = publicController.text;
              AppUser.privateKey = privateController.text;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Home()
              ));
            }, "Login", screenWidth),
            SizedBox(height: screenHeight / 10),
          ],
        ),
      ),
    );
  }
}
