import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Widgets/AppColors.dart';

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();

  final String title;
  final String description;
  final String left;
  final String right;
  final Function()? leftFunc;
  final Function()? rightFunc;
  CustomDialog(this.title, this.description, this.left, this.right, this.leftFunc, this.rightFunc);
}

class _CustomDialogState extends State<CustomDialog> {
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
                  widget.title,
                  style: TextStyle(
                      color: AppColors.blackText, fontSize: screenHeight / 35),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  widget.description,
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                  softWrap: false,
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
                    if (widget.leftFunc != null) TextButton(
                      onPressed: widget.leftFunc,
                      child: Text(
                        widget.left,
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
                      onPressed: widget.rightFunc,
                      child: Text(
                        widget.right,
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
