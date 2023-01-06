
import 'package:url_launcher/url_launcher.dart';

class IntentAction {
  IntentAction._();

  static Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }
}
