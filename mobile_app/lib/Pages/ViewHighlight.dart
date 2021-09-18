import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/Models/Highlight.dart';
import 'package:mobile_app/Widgets/AppButtons.dart';
import 'package:mobile_app/Widgets/AppColors.dart';
import 'package:video_player/video_player.dart';

class ViewHighlight extends StatefulWidget {
  ViewHighlight(this.highlight);
  Highlight highlight;

  @override
  _ViewHighlightState createState() => _ViewHighlightState();
}

class _ViewHighlightState extends State<ViewHighlight> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.highlight.url)
      ..initialize().then((_) {
        setState(() {});
      });
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
        appBar: AppBar(
          title: Text(widget.highlight.name),
          backgroundColor: AppColors.primary,
        ),
        body: Column(
          children: [
            SizedBox(height: screenHeight / 38),
            GestureDetector(
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
                          _controller.value.isPlaying ? Icons.play_arrow : Icons.pause,
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
            widget.highlight.own ? Column(
              children: [
                Text(
                  "Last sold for ${widget.highlight.lastSold} XLM",
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
                SizedBox(height: screenHeight / 2.6),
                AppButtons.getButton(() {
                  //TODO
                }, "List for Sale", screenWidth)
              ],
            ) : Column(
              children: [
                Text(
                  "Current highest bid: ${widget.highlight.currentPrice} XLM",
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
                SizedBox(height: screenHeight / 2.6),
                AppButtons.getButton(() {
                  //TODO
                }, "Place a Bid", screenWidth)
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
