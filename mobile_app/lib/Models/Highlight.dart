import 'dart:core';

class Highlight {
  Highlight(this.name, this.url, this.price, this.owner, this.hash, this.preview);

  String name; // Name of clip from Twitch
  String owner; // Name of current owner of the NFT
  double price; // Current / last sold price in XLM
  String url; // Url to clip on Twitch
  String hash; // Hash of the NFT
  String preview; // Url to clip preview image
}