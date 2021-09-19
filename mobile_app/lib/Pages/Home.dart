import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Models/Highlight.dart';
import 'package:mobile_app/Pages/ViewHighlight.dart';
import 'package:mobile_app/Web/StellarInterface.dart';
import 'package:mobile_app/Widgets/AppColors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    StellarInterface.getUserHighlights();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    List<Highlight> recommendedList = [
      new Highlight("Destroys a Hacker", "Ninja", 12345, "https://production.assets.clips.twitchcdn.net/AT-cm%7C1324683848.mp4?sig=12996e53ea6dfd221f33fa726ab6ca1b49f87d37&token=%7B%22authorization%22%3A%7B%22forbidden%22%3Afalse%2C%22reason%22%3A%22%22%7D%2C%22clip_uri%22%3A%22https%3A%2F%2Fproduction.assets.clips.twitchcdn.net%2FAT-cm%257C1324683848.mp4%22%2C%22device_id%22%3A%224cd9ba0400af2936%22%2C%22expires%22%3A1632056567%2C%22user_id%22%3A%22727572874%22%2C%22version%22%3A2%7D", 4192123, 100, "nick o1iu24poi1u42l1kj4;klj;lrkj;LKFJA;LKJF;ALSJF;LKAJFSD;LKJ", "ALKJDFLKJALKSJF", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_UQcEmQDcQST9jztaIhTvStxK9mll2CQ_4Q&usqp=CAU"),
      new Highlight("Goes beastmode", "Shroud", 235235, "https://production.assets.clips.twitchcdn.net/AT-cm%7C1324683848.mp4?sig=12996e53ea6dfd221f33fa726ab6ca1b49f87d37&token=%7B%22authorization%22%3A%7B%22forbidden%22%3Afalse%2C%22reason%22%3A%22%22%7D%2C%22clip_uri%22%3A%22https%3A%2F%2Fproduction.assets.clips.twitchcdn.net%2FAT-cm%257C1324683848.mp4%22%2C%22device_id%22%3A%224cd9ba0400af2936%22%2C%22expires%22%3A1632056567%2C%22user_id%22%3A%22727572874%22%2C%22version%22%3A2%7D", 332, 100, "nick o1iu24poi1u42l1kj4;klj;lrkj;LKFJA;LKJF;ALSJF;LKAJFSD;LKJ", "ALKJDFLKJALKSJF", "https://i.ytimg.com/vi/YklKZQTZJ6g/maxresdefault.jpg"),
      new Highlight("Ninja and Drake play Fortnite", "Drake", 2352353, "https://production.assets.clips.twitchcdn.net/AT-cm%7C1324683848.mp4?sig=12996e53ea6dfd221f33fa726ab6ca1b49f87d37&token=%7B%22authorization%22%3A%7B%22forbidden%22%3Afalse%2C%22reason%22%3A%22%22%7D%2C%22clip_uri%22%3A%22https%3A%2F%2Fproduction.assets.clips.twitchcdn.net%2FAT-cm%257C1324683848.mp4%22%2C%22device_id%22%3A%224cd9ba0400af2936%22%2C%22expires%22%3A1632056567%2C%22user_id%22%3A%22727572874%22%2C%22version%22%3A2%7D", 6233, 100, "nick o1iu24poi1u42l1kj4;klj;lrkj;LKFJA;LKJF;ALSJF;LKAJFSD;LKJ", "ALKJDFLKJALKSJF", "https://cdn.vox-cdn.com/thumbor/uekGnbouSy0tnfiiwT-7lYduZfM=/0x0:1264x696/1400x933/filters:focal(424x243:626x445):no_upscale()/cdn.vox-cdn.com/uploads/chorus_image/image/59343895/Screen_Shot_2018_04_10_at_6.19.26_PM.1523409062.png"),
      new Highlight("Donda performance", "Kanye", 235232, "https://production.assets.clips.twitchcdn.net/AT-cm%7C1324683848.mp4?sig=12996e53ea6dfd221f33fa726ab6ca1b49f87d37&token=%7B%22authorization%22%3A%7B%22forbidden%22%3Afalse%2C%22reason%22%3A%22%22%7D%2C%22clip_uri%22%3A%22https%3A%2F%2Fproduction.assets.clips.twitchcdn.net%2FAT-cm%257C1324683848.mp4%22%2C%22device_id%22%3A%224cd9ba0400af2936%22%2C%22expires%22%3A1632056567%2C%22user_id%22%3A%22727572874%22%2C%22version%22%3A2%7D", 1241, 100, "nick o1iu24poi1u42l1kj4;klj;lrkj;LKFJA;LKJF;ALSJF;LKAJFSD;LKJ", "ALKJDFLKJALKSJF", "https://www.rollingstone.com/wp-content/uploads/2021/08/kanye-west-donda-review.jpg"),
    ];
    List<Widget> recommendedListWidgets = [SizedBox(width: 12)];
    for (Highlight h in recommendedList) {
      recommendedListWidgets.add(getClipPreview(h, screenHeight, screenWidth));
      recommendedListWidgets.add(SizedBox(width: 12));
    }

    List<Highlight> ownedClipsList = [
      new Highlight("Katowice Finals", "CSGO", 566666, "https://production.assets.clips.twitchcdn.net/AT-cm%7C1324683848.mp4?sig=12996e53ea6dfd221f33fa726ab6ca1b49f87d37&token=%7B%22authorization%22%3A%7B%22forbidden%22%3Afalse%2C%22reason%22%3A%22%22%7D%2C%22clip_uri%22%3A%22https%3A%2F%2Fproduction.assets.clips.twitchcdn.net%2FAT-cm%257C1324683848.mp4%22%2C%22device_id%22%3A%224cd9ba0400af2936%22%2C%22expires%22%3A1632056567%2C%22user_id%22%3A%22727572874%22%2C%22version%22%3A2%7D", 120, null, "GB6LX4OCRXIPK2AZTUGUMZI4AKWE2I6UDCJ3H26BRY5ZSS4FGZCEBBPN", "ALKJDFLKJALKSJF", "https://static-cdn.eleague.com/gallery/_0001_399826_0310_%20%281%29.jpg"),
      new Highlight("Dream Finds Diamonds", "Dream", 235235, "https://production.assets.clips.twitchcdn.net/AT-cm%7C1324683848.mp4?sig=12996e53ea6dfd221f33fa726ab6ca1b49f87d37&token=%7B%22authorization%22%3A%7B%22forbidden%22%3Afalse%2C%22reason%22%3A%22%22%7D%2C%22clip_uri%22%3A%22https%3A%2F%2Fproduction.assets.clips.twitchcdn.net%2FAT-cm%257C1324683848.mp4%22%2C%22device_id%22%3A%224cd9ba0400af2936%22%2C%22expires%22%3A1632056567%2C%22user_id%22%3A%22727572874%22%2C%22version%22%3A2%7D", 99999, null, "GB6LX4OCRXIPK2AZTUGUMZI4AKWE2I6UDCJ3H26BRY5ZSS4FGZCEBBPN", "ALKJDFLKJALKSJF", "https://static1.thegamerimages.com/wordpress/wp-content/uploads/2021/05/dream-youtuber.jpg?q=50&fit=contain&w=767&h=404&dpr=1.5"),
      new Highlight("World Championship", "LOL", 19581092851025, "https://production.assets.clips.twitchcdn.net/AT-cm%7C1324683848.mp4?sig=12996e53ea6dfd221f33fa726ab6ca1b49f87d37&token=%7B%22authorization%22%3A%7B%22forbidden%22%3Afalse%2C%22reason%22%3A%22%22%7D%2C%22clip_uri%22%3A%22https%3A%2F%2Fproduction.assets.clips.twitchcdn.net%2FAT-cm%257C1324683848.mp4%22%2C%22device_id%22%3A%224cd9ba0400af2936%22%2C%22expires%22%3A1632056567%2C%22user_id%22%3A%22727572874%22%2C%22version%22%3A2%7D", 1, null, "GB6LX4OCRXIPK2AZTUGUMZI4AKWE2I6UDCJ3H26BRY5ZSS4FGZCEBBPN", "ALKJDFLKJALKSJF", "https://cdn-wp.thesportsrush.com/2020/09/LOL-worlds.jpg"),
    ];
    List<Widget> ownedClipsListWidgets = [SizedBox(width: 12)];
    for (Highlight h in ownedClipsList) {
      ownedClipsListWidgets.add(getClipPreview(h, screenHeight, screenWidth));
      ownedClipsListWidgets.add(SizedBox(width: 12));
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
              SizedBox(height: 10),
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
            ],
          ),
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
