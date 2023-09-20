import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  static String url = Platform.isAndroid
      ? 'http://192.168.1.4:3000/api/v1/'
      : 'http://localhost:3000/api/v1/';

  void setUser(UserModel user) {
    _user = user;
    print("int Set user");
    print(_user);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(Uri.parse("${url}login"), body: {
        'email': email,
        'password': password,
      });

      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user =
            UserModel.fromJson(data["user"]); // Access the "user" field
        setUser(user);
      } else {
        print('Login failed. Please check your credentials.');
      }
    } catch (error) {
      print('An error occurred during login: $error');
    }
  }

  Future<void> signup(String name, String email, String password) async {
    try {
      final response = await http.post(Uri.parse("${url}register"), body: {
        'name': name,
        'email': email,
        'password': password,
      });

      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user =
            UserModel.fromJson(data["user"]); // Access the "user" field
        setUser(user);
      } else {
        print('Signup failed. Please try again.');
      }
    } catch (error) {
      print('An error occurred during signup: $error');
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
