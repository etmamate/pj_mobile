import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pj_mobile/core/constants.dart';

class ApiClient {
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse('$tmdbBaseUrl$endpoint&api_key=$tmdbApiKey');
    try {
      final response = await http.get(url).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }
}