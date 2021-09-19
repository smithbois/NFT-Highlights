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

  // for testing purposes only
  bool userWalletSelected = false;

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
                // For testing purposes, prefill keys for a user wallet
                if (!userWalletSelected) {
                  publicController.text = "GC3MFYNYKFNIGR5SDCERGUDTUO644XTNJAHLSVOIU4KMC6JY5O4Q7GAC";
                  privateController.text = "SAVNYFPJYPPGYSASJE24V5F5RKI3C25CAAC33BD6DDVNCJAWQJQTXNM6";
                  AppUser.recommendedPublicKey = "GBDZLZW3DGVD7B75K4B5X5EFXUNQVNIXYKX2YZLRB2EXJ6TND4VYVDAY";
                  AppUser.recommendedPrivateKey = "SB3KH4K7JIOZSZROGR6LF5PMJ6CWZOWI7JTB5T7ZMS4NGRUQ2ECGAHQD";
                  this.setState(() {
                    userWalletSelected = true;
                  });
                } else {
                  // for testing only, prefill keys for the reccomended wallet
                  publicController.text = "GBDZLZW3DGVD7B75K4B5X5EFXUNQVNIXYKX2YZLRB2EXJ6TND4VYVDAY";
                  privateController.text = "SB3KH4K7JIOZSZROGR6LF5PMJ6CWZOWI7JTB5T7ZMS4NGRUQ2ECGAHQD";
                  AppUser.recommendedPublicKey = "GC3MFYNYKFNIGR5SDCERGUDTUO644XTNJAHLSVOIU4KMC6JY5O4Q7GAC";
                  AppUser.recommendedPrivateKey = "SAVNYFPJYPPGYSASJE24V5F5RKI3C25CAAC33BD6DDVNCJAWQJQTXNM6";
                  this.setState(() {
                    userWalletSelected = false;
                  });
                }

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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
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
