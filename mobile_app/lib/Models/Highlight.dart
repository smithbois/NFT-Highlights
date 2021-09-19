import 'dart:core';

class Highlight {
  Highlight(this.name, this.streamer, this.views, this.url, this.lastSold, this.price, this.ownerAddress, this.hash, this.preview, this.issuerAddress);

  String name; // Name of clip from Twitch
  String streamer; // Name of the streamer
  int views;
  String url; // Url to clip on Twitch
  double lastSold; // Last sold price in XLM
  double? price; // Current price in XLM, if it is up for sale. Otherwise it is null
  String ownerAddress; // Name of current owner of the NFT
  String hash; // Hash of the NFT
  String preview; // Url to clip preview image
  String issuerAddress; // Address of account that issued NFT
}