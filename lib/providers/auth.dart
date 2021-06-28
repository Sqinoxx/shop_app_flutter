import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

enum AuthMode { SingUp, Login }

class Auth with ChangeNotifier {
  String _token; //lebt ca 1h
  DateTime _expiryDate;
  String _userId;
  //NOT FINAL

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyB8IVZuknCKjpM5gKwuf0h-Uaes7KIuRS8';
    final response = await http.post(
      Uri.parse(
        url,
      ),
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(json.decode(response.body));
  }

  Future<void> singup(String email, String password) async {
    const urlSegment = 'signUp';
    // const url =
    // 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB8IVZuknCKjpM5gKwuf0h-Uaes7KIuRS8';
    return _authenticate(email, password, urlSegment);
  }

  Future<void> singin(String email, String password) async {
    const urlSegment = 'signInWithPassword';
    // const url =
    // 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyB8IVZuknCKjpM5gKwuf0h-Uaes7KIuRS8';
    return _authenticate(email, password, urlSegment);
  }
}
