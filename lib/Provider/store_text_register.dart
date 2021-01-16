import 'package:flutter/cupertino.dart';

class StoreTextRegister extends ChangeNotifier{
  String _name,_surname,_date,_password,_phoneNo;

  String get name => _name;
  String get surname => _surname;
  String get date => _date;
  String get password => _password;
  String get phoneNo => _phoneNo;

  setName(String name){
    _name = name;
    notifyListeners();
  }

  setSurname(String surname){
    _surname = surname;
    notifyListeners();
  }

  setDate(String date){
    _date = date;
    notifyListeners();
  }

  setPassword(String password){
    _password = password;
    notifyListeners();
  }

  setPhoneNo(String phoneNo){
    _phoneNo = phoneNo;
    notifyListeners();
  }

}