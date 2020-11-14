import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  String rstr;
  String lstr;
  User usr;

  void lerrorstr(error) {
    lstr = error;
    notifyListeners();
  }

  void rerrorstr(error) {
    rstr = error;
    notifyListeners();
  }

  Future login(email, password) async {}

  Future register(email, password, name) async {}
}
