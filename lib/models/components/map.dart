import 'package:url_launcher/url_launcher.dart';

class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}

class URl{
  static Future<void> open({required String Link}) async {
    if (await canLaunchUrl(Uri.parse(Link))) {
      await launchUrl(Uri.parse(Link));
    } else {
      throw 'Could not open the map.';
    }
  }
}