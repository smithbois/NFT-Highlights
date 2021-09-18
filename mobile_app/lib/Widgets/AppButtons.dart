import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Widgets/AppColors.dart';

class AppButtons {
  static Align getButton(var function, String s, double screenWidth, [bool spin=false]) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: screenWidth / 1.8,
        child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(screenWidth / 30, 13, screenWidth / 30, 13)),
              foregroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
              backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(1000)))),
            ),
            onPressed: function,
            child: spin ? CircularProgressIndicator(
              color: AppColors.white,
            ) : Text(
              s,
              style: TextStyle(
                color: AppColors.white,
                fontSize: screenWidth / 24,
              ),
              textAlign: TextAlign.center,
            )
        ),
      )
    );
  }
}