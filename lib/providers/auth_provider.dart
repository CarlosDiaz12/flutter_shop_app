import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  final _url =
      Uri.https('identitytoolkit.googleapis.com', '/v1/accounts:signUp', {
    'key': 'AIzaSyAxRxWqXo1Wc8eaA1m0hCxIP54vXcetozU',
  });
  String? _token;
  DateTime? _tokenExpireDate;
  String? _userId;
  String? get userId => _userId;
  bool get isLoggedIn {
    return _token != null;
  }

  String? get token {
    if (_tokenExpireDate != null &&
        _tokenExpireDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signUp(String email, String password) async {
    try {
      var payload = {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      };
      var response = await http.post(_url, body: json.encode(payload));
      if (response.statusCode != HttpStatus.ok) {
        var res = json.decode(response.body);

        throw Exception(
            res['error']['message'] ?? 'Error trying to sign up user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      var _endopint = _url.replace(path: '/v1/accounts:signInWithPassword');
      var payload = {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      };
      var response = await http.post(_endopint, body: json.encode(payload));
      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Error trying to sign in user');
      }

      var res = json.decode(response.body);
      _token = res['idToken'];
      _tokenExpireDate =
          DateTime.now().add(Duration(seconds: int.parse(res['expiresIn'])));
      _userId = res['localId'];
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
