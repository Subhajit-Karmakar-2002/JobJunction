import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscuretext = true;

  bool get obscuretext => _obscuretext;

  set obscuretext(bool value) {
    _obscuretext = value;
    notifyListeners();
  }
}
