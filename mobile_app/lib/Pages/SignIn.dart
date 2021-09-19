import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Models/AppUser.dart';
import 'package:mobile_app/Widgets/AppButtons.dart';
import 'package:mobile_app/Widgets/AppColors.dart';
import 'package:mobile_app/Widgets/AppTextField.dart';

import 'Home.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  late TextEditingController publicController;
  late TextEditingController privateController;

  // for testing purposes only
  bool userWalletSelected = false;
  static final String user1Pub = "GC3TFFTOOBRY2SL2DR7RTIXKZ52N2AWLEAAXI4KI36MDXWMLU6LEFAJF";
  static final String user1Priv = "SCOVEM5SHPYCZBEM3FZDX3C7CZ3PLORACGSDGR3QWN6LQEFM3LOYS7LH";
  static final String user2Pub = "GC3BVLOPHWNUH5WQOLT5DZLVUSSF3IP32INK6X5UC2ALJMNDOK56X473";
  static final String user2Priv = "SD4IPDD22BMW2SRIDI4JCRV2DBPMPGVQWY6N65DXQV64P7FXN4J6PZKV";

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
                  publicController.text = user1Pub;
                  privateController.text = user1Priv;
                  AppUser.recommendedPublicKey = user2Pub;
                  AppUser.recommendedPrivateKey = user2Priv;
                  this.setState(() {
                    userWalletSelected = true;
                  });
                } else {
                  // for testing only, prefill keys for the reccomended wallet
                  publicController.text = user2Pub;
                  privateController.text = user2Priv;
                  AppUser.recommendedPublicKey = user1Pub;
                  AppUser.recommendedPrivateKey = user1Priv;
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
