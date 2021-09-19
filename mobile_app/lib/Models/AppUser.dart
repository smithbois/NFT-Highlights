
import 'package:mobile_app/Models/Highlight.dart';
import 'package:mobile_app/Pages/SignIn.dart';

class AppUser {
  static String publicKey = "";
  static String privateKey = "";
  static List<Highlight> ownedHighlights = [];
  static double balance = 0;

  static String recommendedPublicKey = SignInState.user2Pub;
  static String recommendedPrivateKey = SignInState.user2Priv;
  static List<Highlight> recommendedHighlights = [];
}