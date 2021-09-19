import 'package:mobile_app/Models/AppUser.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StellarInterface {
  static getUserHighlights() async {
    AccountResponse account = await StellarSDK.TESTNET.accounts.account(AppUser.publicKey);
    List<Balance?> balances = [];
    if (account.balances != null) {
      balances = account.balances!;
    }

    List<String> issuerAddresses = [];
    for (Balance? balance in balances) {
      if (balance != null && balance.assetCode == "Highlight") {
        // This is one of our NFTs
        if (balance.assetIssuer != null) {
          issuerAddresses.add(balance.assetIssuer!);
        }
      }
    }

    String twitchAccessToken = await getTwitchAuth();

    for (String issuerAddress in issuerAddresses) {
      AccountResponse account = await StellarSDK.TESTNET.accounts.account(issuerAddress);
      if (account.data != null) {
        try {
          String url = new String.fromCharCodes(base64Decode(account.data!['highlightURL']));
          print(url);

          String endpointLink = "https://api.twitch.tv/helix/clips?id=$url";
          Map<String, String>? requestHeader = {
            "Authorization": "Bearer $twitchAccessToken",
            "Client-Id": "2q3fztm320kn3bnqlnv4go1kih7kxr",
          };
          var response = await http.get(Uri.parse(endpointLink), headers: requestHeader);
          if (response.statusCode != 200) {
            throw Exception(response.body);
          }
          print(response.body);
          // https://clips-media-assets2.twitch.tv/AT-cm%7C1323884122-preview-480x272.jpg
        } catch (e) {
          print(e);
        }
      }
    }
  }

  static getTwitchAuth() async {
    String clientID = "2q3fztm320kn3bnqlnv4go1kih7kxr";
    String clientSecret = "oghle2l2xz41f2xp21j9sxvfeozuyz";

    String authEndpointLink = "https://id.twitch.tv/oauth2/token?client_id=$clientID&client_secret="
        "$clientSecret&grant_type=client_credentials";
    var authResponse = await http.post(Uri.parse(authEndpointLink));
    if (authResponse.statusCode != 200) {
      throw Exception(authResponse.body);
    }
    print(authResponse.body);
    return json.decode(authResponse.body)["access_token"];
  }
}