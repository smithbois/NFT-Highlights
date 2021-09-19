import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Models/Highlight.dart';
import 'package:mobile_app/Pages/Home.dart';
import 'package:mobile_app/Web/StellarInterface.dart';
import 'package:mobile_app/Widgets/AppColors.dart';

import 'CustomDialog.dart';

class BuyDialog extends StatefulWidget {
  @override
  _BuyDialogState createState() => _BuyDialogState();

  final Highlight highlight;
  final HomeState home;
  BuyDialog(this.highlight, this.home);
}

class _BuyDialogState extends State<BuyDialog> {
  bool loading = false;
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Align(
      child: SizedBox(
        height: screenHeight / 4,
        width: screenWidth / 1.2,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Card(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight / 30),
                Text(
                  "Confirm Purchase",
                  style: TextStyle(
                      color: AppColors.blackText, fontSize: screenHeight / 35),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  "Confirm purchase for ${widget.highlight.price} XLM?",
                  style: TextStyle(
                    color: AppColors.blackText, fontSize: screenHeight / 60,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: screenWidth / 25,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(screenWidth / 30, screenHeight / 100, screenWidth / 30, screenHeight / 100)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                      ),
                      onPressed: () async {
                        if (loading) return;
                        setState(() {
                          loading = true;
                        });
                        bool success = await StellarInterface.purchaseToken(widget.highlight.issuerAddress, widget.highlight.price.toString());
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        if (success) {
                          double price = widget.highlight.price!;
                          print(price);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog("Successfully Bought", "NFT has successfully been bought for\n$price XLM!", "", "Done", null, () {
                                Navigator.of(context).pop();
                              });
                            },
                          );
                          setState(() {
                            widget.home.initState();
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog("An Error Occurred", "NFT purchase has had an error.", "", "Done", null, () {
                                Navigator.of(context).pop();
                              });
                            },
                          );
                        }
                      },
                      child: loading ? CircularProgressIndicator(
                        color: AppColors.white,
                      )
                          : Text(
                        "Buy Now",
                        style: TextStyle(
                          fontSize: screenWidth / 25,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: screenHeight / 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
