import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/Models/AppUser.dart';
import 'package:mobile_app/Models/Highlight.dart';
import 'package:mobile_app/Pages/ViewHighlight.dart';
import 'package:mobile_app/Web/StellarInterface.dart';
import 'package:mobile_app/Widgets/AppColors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Highlight> ownedClips = [];
  List<Highlight> recommendedList = [];

  @override
  void initState() {
    var updateOwnedListCallback = () {
      print('updating state');
      this.setState(() {
        ownedClips = AppUser.ownedHighlights;
      });
    };
    var updateRecommendedListCallback = () {
      print('updating state');
      this.setState(() {
        recommendedList = AppUser.recommendedHighlights;
      });
    };
    StellarInterface.getUserHighlights(AppUser.publicKey, updateOwnedListCallback);
    StellarInterface.getUserHighlights(AppUser.recommendedPublicKey, updateRecommendedListCallback, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building home screen');
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    List<Widget> recommendedListWidgets = [SizedBox(width: 12)];
    for (Highlight h in recommendedList) {
      recommendedListWidgets.add(getClipPreview(h, screenHeight, screenWidth));
      recommendedListWidgets.add(SizedBox(width: 12));
    }

    List<Widget> ownedClipsListWidgets = [SizedBox(width: 12)];
    for (Highlight h in ownedClips) {
      ownedClipsListWidgets.add(getClipPreview(h, screenHeight, screenWidth));
      ownedClipsListWidgets.add(SizedBox(width: 12));
    }

    print(ownedClipsListWidgets.length);
    if (recommendedListWidgets.length == 1)
      recommendedListWidgets = [
        CircularProgressIndicator(color: AppColors.white),
      ];
    if (ownedClipsListWidgets.length == 1)
      ownedClipsListWidgets = [
        CircularProgressIndicator(color: AppColors.white),
      ];

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.gray,
        body: Column(
          children: [
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "Recommended Highlights For Sale",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: screenHeight / 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: recommendedListWidgets,
              ),
            ),

            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "Your Highlights",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: screenHeight / 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ownedClipsListWidgets,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget getClipPreview(Highlight highlight, var screenHeight, var screenWidth) {
    var height = screenHeight / 3.25;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewHighlight(highlight),
        ));
      },
      child: SizedBox(
        height: height,
        child:
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          color: AppColors.white,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    SizedBox(
                      width: screenWidth / 3,
                      child: Text(
                        highlight.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenHeight / 60,
                          color: AppColors.blackText,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: screenWidth / 3,
                      child: Text(
                        "${highlight.lastSold} XLM",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenHeight / 60,
                          color: AppColors.blackText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: height / 1.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: highlight.preview == "" ?
                  Image(
                    image: AssetImage("assets/defaultImage.jpg"),
                    fit: BoxFit.fitWidth,
                  ) : Image.network(
                    highlight.preview,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
