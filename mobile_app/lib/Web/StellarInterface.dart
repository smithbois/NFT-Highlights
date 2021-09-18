import 'package:mobile_app/Models/AppUser.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

class StellarInterface {
  static getUserHighlights() {
    KeyPair kp = KeyPair.fromSecretSeed(AppUser.privateKey);
    StellarSDK.TESTNET.transactions.forAccount(AppUser.publicKey);
  }
}