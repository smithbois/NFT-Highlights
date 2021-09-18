import 'package:flutter/material.dart';
import 'package:mobile_app/Widgets/AppColors.dart';

class AppTextField {
  static Widget getTextField(TextEditingController controller, String s, var screenHeight, var screenWidth) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.darkGray,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            height: screenHeight * .06,
            width: screenWidth * .8,
          ),
        ),
        Positioned(
          top: 7,
          width: screenWidth * .8,
          child: TextField(
            //controller: controller,
            style: TextStyle(color: AppColors.white, fontSize: screenHeight / 50),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(screenHeight/60),
              isDense: true,
              focusedBorder: OutlineInputBorder( // Selected border
                borderSide: BorderSide(color: AppColors.gray, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: OutlineInputBorder( // Unselected border
                borderSide: BorderSide(color: AppColors.gray, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
        Positioned(
          top: 7,
          left: 15,
          child: Text(
            s,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: screenHeight / 90,
            ),
          ),
        ),
      ],
    );
  }
}