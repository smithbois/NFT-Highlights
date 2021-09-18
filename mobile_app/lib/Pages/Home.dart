import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Models/Highlight.dart';
import 'package:mobile_app/Widgets/AppColors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    List<Highlight> recommendedList = [
      new Highlight("Test Clip Name", "google.com", 500, "nick o1iu24poi1u42l1kj4;klj;lrkj;LKFJA;LKJF;ALSJF;LKAJFSD;LKJ", "ALKJDFLKJALKSJF", "https://clips-media-assets2.twitch.tv/AT-cm%7C1324683848-preview-260x147.jpg"),
      new Highlight("Test Clip Name", "google.com", 500, "nick o1iu24poi1u42l1kj4;klj;lrkj;LKFJA;LKJF;ALSJF;LKAJFSD;LKJ", "ALKJDFLKJALKSJF", "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
      new Highlight("Test Clip Name", "google.com", 500, "nick o1iu24poi1u42l1kj4;klj;lrkj;LKFJA;LKJF;ALSJF;LKAJFSD;LKJ", "ALKJDFLKJALKSJF", "https://clips-media-assets2.twitch.tv/AT-cm%7C1324683848-preview-260x147.jpg"),
      new Highlight("Test Clip Name", "google.com", 500, "nick o1iu24poi1u42l1kj4;klj;lrkj;LKFJA;LKJF;ALSJF;LKAJFSD;LKJ", "ALKJDFLKJALKSJF", "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
    ];

    List<Widget> recommendedListWidgets = [SizedBox(width: 12)];
    for (Highlight h in recommendedList) {
      recommendedListWidgets.add(getClipPreview(h, screenHeight, screenWidth));
      recommendedListWidgets.add(SizedBox(width: 12));
    }

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.gray,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Recommended NFTs For Sale",
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
            ],
          ),
        ),
      ),
    );
  }

  Widget getClipPreview(Highlight highlight, var screenHeight, var screenWidth) {
    print(highlight.preview);
    var height = screenHeight / 3.25;
    return GestureDetector(
      onTap: () { // TODO
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
                          fontSize: screenHeight / 50,
                          color: AppColors.blackText,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: screenWidth / 3,
                      child: Text(
                        "${highlight.price} XLM",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenHeight / 50,
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
