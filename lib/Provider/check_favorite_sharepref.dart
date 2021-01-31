import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends ChangeNotifier{
  final String key = "_favorite";
  SharedPreferences _prefs;
  bool _checkFavorite;

  bool get checkFavorite => _checkFavorite;


  Favorite() {
    _checkFavorite = true;
    _loadFromPrefs();

  }

  toggleFavorite() {
    _checkFavorite = !_checkFavorite;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if(_prefs == null)
      _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _checkFavorite = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs()async {
    await _initPrefs();
    _prefs.setBool(key, _checkFavorite);
  }
}