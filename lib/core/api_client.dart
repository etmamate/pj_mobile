import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pj_mobile/core/constants.dart';

class ApiClient {
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse('$tmdbBaseUrl$endpoint&api_key=$tmdbApiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data:  ${response.statusCode}');
    }
  }
}
