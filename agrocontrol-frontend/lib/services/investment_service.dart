import 'dart:convert';
import 'package:http/http.dart' as http;

class InvestmentService {
  static const String baseUrl = 'http://localhost:4000/api/inversiones';

  Future<List> getInvestments() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return [];
    }
  }

  Future addInvestment(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (res.statusCode == 201) {
      return true;
    } else {
      final body = jsonDecode(res.body);
      return body['error'] ?? 'Error desconocido';
    }
  }
}
