import 'dart:io';
import 'package:http/http.dart' as http;

class Utils {
  static Future<bool> isInternetConnected() async {
    try {
      final result = await http.get(Uri.parse('http://www.google.com'));
      if (result.statusCode == 200) {
        return true;
      }
    } on SocketException catch (_) {
      // Nothing to do
    }
    return false;
  }
}
