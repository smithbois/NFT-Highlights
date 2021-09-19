import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Models/Highlight.dart';
import 'package:mobile_app/Web/StellarInterface.dart';
import 'package:mobile_app/Widgets/AppColors.dart';

class SellDialog extends StatefulWidget {
  @override
  _SellDialogState createState() => _SellDialogState();

  final Highlight highlight;
  SellDialog(this.highlight);
}

class _SellDialogState extends State<SellDialog> {
  bool visible = false;
  bool loading = false;
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // TODO: Get the price from the textbook

    return Align(
      child: SizedBox(
        height: screenHeight / 2.88,
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
                getTextboxQuestion("Sale Price (XLM)", screenHeight, screenWidth),
                Spacer(),
                Visibility(
                  visible: visible,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "* Please enter a price",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: screenHeight/60,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
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
                        if (controller.text.length == 0) {
                          setState(() {
                            visible = true;
                          });
                        } else {
                          setState(() {
                            loading = true;
                          });
                          await StellarInterface.putTokenForSale(widget.highlight.issuerAddress, "100");
                          // TODO: Success message
                        }
                      },
                      child: loading ? CircularProgressIndicator(
                        color: AppColors.white,
                      )
                      : Text(
                        "Start",
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

  Align getTextboxQuestion(String question, double screenHeight, double screenWidth) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            question,
            textScaleFactor: 1.0,
            style: TextStyle(
                color: AppColors.blackText, fontSize: screenHeight / 35),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            "Last sold for ${widget.highlight.lastSold} XLM",
            textScaleFactor: 1.0,
            style: TextStyle(
              color: AppColors.blackText, fontSize: screenHeight / 60,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          SizedBox(
            width: screenWidth / 1.4,
            height: screenHeight / 20,
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (String s) {
                setState(() {
                  visible = false;
                });
              },
              controller: controller,
              style: TextStyle(color: AppColors.blackText, fontSize: 14),
              decoration: InputDecoration(
                hintText: "Enter prize name...",
                isDense: true,
                focusedBorder: OutlineInputBorder( // Selected border
                  borderSide: BorderSide(color: AppColors.highlight, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder( // Unselected border
                  borderSide: BorderSide(color: AppColors.lightGray, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
