import 'package:mobile_app/Models/AppUser.dart';
import 'package:mobile_app/Models/Highlight.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StellarInterface {

  static getBalance(String publicAddress, [var callback]) async {
    AccountResponse account = await StellarSDK.TESTNET.accounts.account(publicAddress);
    List<Balance?> balances = [];
    if (account.balances != null) {
      balances = account.balances!;
    }
    for (Balance? balance in balances) {
      if (balance != null && balance.assetType == 'native') {
        print('User balance: ${balance.balance}');
        AppUser.balance = double.parse(balance.balance!);
        if (callback != null) {
          callback();
        }
      }
    }
  }

  static getUserHighlights(String publicAddress, [dynamic updateStateCallback, bool isOwned=true]) async {
    AccountResponse account = await StellarSDK.TESTNET.accounts.account(publicAddress);
    List<Balance?> balances = [];
    if (account.balances != null) {
      balances = account.balances!;
    }

    List<String> issuerAddresses = [];
    for (Balance? balance in balances) {
      if (balance != null && balance.assetCode == "Highlight") {
        // This is one of our NFTs
        if (balance.assetIssuer != null && double.parse(balance.balance!) >= 1) {
          issuerAddresses.add(balance.assetIssuer!);
          print(balance.balance);
        }
      }
    }

    String twitchAccessToken = await getTwitchAuth();

    List<Highlight> ownedHighlights = [];

    for (String issuerAddress in issuerAddresses) {
      AccountResponse account = await StellarSDK.TESTNET.accounts.account(issuerAddress);
      if (account.data != null) {
        try {
          String url = new String.fromCharCodes(base64Decode(account.data!['highlightURL']));
          String lastSold = new String.fromCharCodes(base64Decode(account.data!['lastSold']));
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
          var data = json.decode(response.body)['data'][0];
          String name = data['title'];
          String streamer = data['broadcaster_name'];
          int viewCount = data['view_count'];
          String thumbnailUrl = data['thumbnail_url'];
          String fileUrl = thumbnailUrl.substring(0, thumbnailUrl.length-20) + ".mp4";
          print(fileUrl);

          String ownerAddress = publicAddress;
          String hash = account.hashCode.toString();
          // https://clips-media-assets2.twitch.tv/AT-cm%7C1323884122-preview-480x272.jpg

          // check if there is an active sell order for the highlight
          Asset nft = AssetTypeCreditAlphaNum12("Highlight", issuerAddress);
          OrderBookResponse obr = await StellarSDK.TESTNET.orderBook.sellingAsset(nft).buyingAsset(Asset.NATIVE).execute();
          double? price;
          if (obr.asks != null && obr.asks!.isNotEmpty) {
            print('getting price');
            price = double.parse(obr.asks![0]!.price!);
            print('got price: $price');
          } else {
            price = null;
          }

          if (!isOwned && price == null) {
            break;
          }


          print(issuerAddress);
          Highlight h = new Highlight(name, streamer, viewCount, fileUrl, double.parse(lastSold), price, ownerAddress, hash, thumbnailUrl, issuerAddress);
          ownedHighlights.add(h);


        } catch (e) {
          print(e);
        }
      }
    }

    if (isOwned) {
      AppUser.ownedHighlights = ownedHighlights;
    } else {
      AppUser.recommendedHighlights = ownedHighlights;
    }

    print('finished getting owned highlights');
    updateStateCallback();
  }
  
  static putTokenForSale(String issuerAddress, String price) async {
    KeyPair senderKeyPair = KeyPair.fromSecretSeed(AppUser.privateKey);
    
    AccountResponse seller = await StellarSDK.TESTNET.accounts.account(senderKeyPair.accountId);
    Asset nft = AssetTypeCreditAlphaNum12("Highlight", issuerAddress);

    Transaction transaction = new TransactionBuilder(seller)
      .addOperation(ManageSellOfferOperationBuilder(nft, Asset.NATIVE, "1", price).build())
      .build();

    transaction.sign(senderKeyPair, Network.TESTNET);
    SubmitTransactionResponse response = await StellarSDK.TESTNET.submitTransaction(transaction);
    return(response.success);
  }

  static removeTokenFromSale(String issuerAddress, String price) async {
    KeyPair senderKeyPair = KeyPair.fromSecretSeed(AppUser.privateKey);

    AccountResponse seller = await StellarSDK.TESTNET.accounts.account(senderKeyPair.accountId);
    Asset nft = AssetTypeCreditAlphaNum12("Highlight", issuerAddress);

    Transaction transaction = new TransactionBuilder(seller)
        .addOperation(ManageSellOfferOperationBuilder(nft, Asset.NATIVE, "0", price).build())
        .build();

    transaction.sign(senderKeyPair, Network.TESTNET);
    SubmitTransactionResponse response = await StellarSDK.TESTNET.submitTransaction(transaction);
    return(response.success);
  }

  static purchaseToken(String issuerAddress, String price) async {
    KeyPair senderKeyPair = KeyPair.fromSecretSeed(AppUser.privateKey);

    AccountResponse buyer = await StellarSDK.TESTNET.accounts.account(senderKeyPair.accountId);
    Asset nft = AssetTypeCreditAlphaNum12("Highlight", issuerAddress);

    Transaction transaction = new TransactionBuilder(buyer)
        .addOperation(ChangeTrustOperationBuilder(nft, "100").build())
        .addOperation(ManageBuyOfferOperationBuilder(Asset.NATIVE, nft, "1", price).build())
        .build();

    transaction.sign(senderKeyPair, Network.TESTNET);
    SubmitTransactionResponse response = await StellarSDK.TESTNET.submitTransaction(transaction);
    return(response.success);
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