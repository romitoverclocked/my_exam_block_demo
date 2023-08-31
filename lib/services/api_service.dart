import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = 'https://dev-api.globalultrasoundinstitute.com/';

  static Future<http.Response?> getApi(
      String url, Map<String, String> header) async {
    log(url, name: 'GET API URL');
    log(header.toString(), name: 'GET API HEADERS');
    try {
      return await http.get(Uri.parse(url), headers: header);
    } catch (e) {
      log(e.toString(), name: "API FAILED");
      return null;
    }
  }

  static Future<http.Response?> postApi(
      String url, body, Map<String, String> headers) async {
    log(url, name: 'POST API URL');
    log(headers.toString(), name: 'POST API HEADERS');
    log(body.toString(), name: 'POST API BODY');
    try {
      return await http.post(Uri.parse(url),
          body: body, headers: headers);
    } catch (e) {
      log(e.toString(), name: "API FAILED");
      return null;
    }
  }
}
