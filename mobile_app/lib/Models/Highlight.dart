import 'dart:core';

class Highlight {
  Highlight(this.name, this.url, this.lastSold, this.currentPrice, this.owner, this.hash, this.preview, this.own);

  String name; // Name of clip from Twitch
  String url; // Url to clip on Twitch
  double lastSold; // Last sold price in XLM
  double currentPrice; // Current auction price in XLM
  String owner; // Name of current owner of the NFT
  String hash; // Hash of the NFT
  String preview; // Url to clip preview image
  bool own; // Does the current user own the nft
}