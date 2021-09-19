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
  late TextEditingController publicController;
  late TextEditingController privateController;

  @override
  void initState() {
    publicController = new TextEditingController();
    privateController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;


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
            GestureDetector(
              onTap: () {
                // For testing purposes
                publicController.text = "GB6LX4OCRXIPK2AZTUGUMZI4AKWE2I6UDCJ3H26BRY5ZSS4FGZCEBBPN";
                privateController.text = "SA3WJAENZCZ4FNV7NSQTDRSTESYSXGE37BIZHMIVASH3WDEW6MZF32P4";
              },
              child: Image(
                  width: screenWidth * .78,
                  image: AssetImage("assets/logo.png")
              ),
            ),
            SizedBox(height: 30),
            AppTextField.getTextField(publicController, "Public Key", screenHeight, screenWidth),
            SizedBox(height: 20),
            AppTextField.getTextField(privateController, "Private Key", screenHeight, screenWidth),
            Spacer(),
            AppButtons.getButton(() {
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
