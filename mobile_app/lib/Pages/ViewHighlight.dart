import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/Models/AppUser.dart';
import 'package:mobile_app/Models/Highlight.dart';
import 'package:mobile_app/Pages/Home.dart';
import 'package:mobile_app/Web/StellarInterface.dart';
import 'package:mobile_app/Widgets/AppButtons.dart';
import 'package:mobile_app/Widgets/AppColors.dart';
import 'package:mobile_app/Widgets/BuyDialog.dart';
import 'package:mobile_app/Widgets/CustomDialog.dart';
import 'package:mobile_app/Widgets/SellDialog.dart';
import 'package:video_player/video_player.dart';

class ViewHighlight extends StatefulWidget {
  final Highlight highlight;
  final HomeState home;

  ViewHighlight(this.highlight, this.home);

  @override
  _ViewHighlightState createState() => _ViewHighlightState();
}

class _ViewHighlightState extends State<ViewHighlight> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        widget.highlight.url)
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    print(widget.highlight.price);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.gray,
        appBar: AppBar(
          title: Text("NFT Highlights"),
          backgroundColor: AppColors.primary,
        ),
        body: Column(
          children: [
            SizedBox(height: screenHeight / 38),
            if (_controller.value.isInitialized) GestureDetector(
              onTap: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: screenWidth * .9,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedOpacity(
                      child: Container(
                        child: Icon(
                          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: screenWidth / 8,
                        ),
                      ),
                      opacity: _controller.value.isPlaying ? 0 : 1,
                      duration: const Duration(milliseconds: 300),
                    )
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight / 30),
            widget.highlight.ownerAddress == AppUser.publicKey ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                  child: Text(
                    "${widget.highlight.streamer}: ${widget.highlight.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: screenHeight / 40,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight / 200),
                Text(
                  "Last sold for ${NumberFormat("###,###.0").format(widget.highlight.lastSold)} XLM",
                  style: TextStyle(
                    fontSize: screenHeight / 60,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                if (widget.highlight.price != null) SizedBox(height: screenHeight / 100),
                if (widget.highlight.price != null) Text(
                  "Your current listing: ${NumberFormat("###,###.0").format(widget.highlight.price)} XLM",
                  style: TextStyle(
                    fontSize: screenHeight / 60,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: screenHeight / 100),
                Text(
                  "${NumberFormat("###,###").format(widget.highlight.views)} views",
                  style: TextStyle(
                    fontSize: screenHeight / 60,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: screenHeight / 100),
                TextButton.icon(
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: widget.highlight.hash)).then((_){
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content:Text("NFT hash copied to clipboard")));
                    });
                  },
                  icon: Icon(Icons.copy),
                  label: Text("Copy Hash"),
                ),
                SizedBox(height: widget.highlight.price == null ? screenHeight / 3.2 : screenHeight / 4),
                widget.highlight.price == null ? AppButtons.getButton(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SellDialog(widget.highlight);
                    },
                  );
                }, "List for sale", screenWidth) : AppButtons.getButton(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog("Remove listing?", "Are you sure you want to\nremove your NFT from the market?", "Cancel", "Confirm", () {
                        Navigator.of(context).pop();
                      }, () async {
                        bool removeSucceeded = await StellarInterface.removeTokenFromSale(widget.highlight.issuerAddress, widget.highlight.price.toString());
                        Navigator.of(context).pop();
                        if (removeSucceeded) {
                          widget.highlight.price = null;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog("Success", "Your NFT has successfully been\npulled from the market!", "", "Done", null, () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              });
                            }
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog("Error", "There was an error", "", "Done", null, () {
                                  Navigator.of(context).pop();
                                });
                              }
                          );
                        }
                      });
                    },
                  );
                }, "Remove from listing", screenWidth)
              ],
            ) : Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                  child: Text(
                    "${widget.highlight.streamer}: ${widget.highlight.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: screenHeight / 40,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight / 200),
                Text(
                  "For sale: ${NumberFormat("###.0").format(widget.highlight.price)} XLM",
                  style: TextStyle(
                    fontSize: screenHeight / 60,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: screenHeight / 100),
                Text(
                  "Last sold for ${NumberFormat("###,###.0").format(widget.highlight.lastSold)} XLM",
                  style: TextStyle(
                    fontSize: screenHeight / 60,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: screenHeight / 100),
                Text(
                  "${NumberFormat("###,###").format(widget.highlight.views)} views",
                  style: TextStyle(
                    fontSize: screenHeight / 60,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: screenHeight / 100),
                TextButton.icon(
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: widget.highlight.hash)).then((_){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content:Text("NFT hash copied to clipboard")));
                    });
                  },
                  icon: Icon(Icons.copy),
                  label: Text("Copy Hash"),
                ),
                SizedBox(height: screenHeight / 3.2),
                AppButtons.getButton(() {
                  //TODO
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BuyDialog(widget.highlight, widget.home);
                    },
                  );
                }, "Buy Now", screenWidth)
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
