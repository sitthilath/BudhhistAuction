import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreToken extends ChangeNotifier{
  final String key = "_tokens";
  SharedPreferences _prefs;

   String _tokens;

  String get tokens => _tokens;

  StoreToken(){
    _loadFromPrefs();
  }

  setTokens(String tokens) {
    _tokens = tokens;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if(_prefs == null)
      _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _tokens = _prefs.getString(key) ?? '';
    notifyListeners();
  }

  _saveToPrefs()async {
    await _initPrefs();
    _prefs.setString(key, _tokens);
  }

}