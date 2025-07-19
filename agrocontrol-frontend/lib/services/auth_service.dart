import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  static const String baseUrl = 'http://localhost:4000/api/auth';
  String? _token;
  String? get token => _token;

  Future login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode == 200) {
      // Aquí podrías guardar el token si el backend lo retorna
      return true;
    } else {
      final data = jsonDecode(res.body);
      return data['error'] ?? 'Error desconocido';
    }
  }

  Future register(String nombre, String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nombre': nombre, 'email': email, 'password': password}),
    );
    if (res.statusCode == 201) {
      return true;
    } else {
      final data = jsonDecode(res.body);
      return data['error'] ?? 'Error desconocido';
    }
  }
}
