import 'dart:io';


import 'package:flutter/cupertino.dart';

class StoreReleaseBuddhist extends ChangeNotifier{
  int _indexItemType,_indexPayThrough,_indexDelivery;
  String _itemName,_itemType,_information,_dateAuction,_timeAuction,_datetimeAuction,_place,_priceStart,_priceSmallest;
  String _payThrough,_bankName,_accountName,_accountNumber;
  String _delivery,_placeDelivery,_phoneNumber,_moreDetail;
  List<File> _listImage = [];
  File _imageBig,_imageSmall1,_imageSmall2,_imageSmall3,_imageSmall4;

  File get imageBig =>_imageBig;
  File get imageSmall1 =>_imageSmall1;
  File get imageSmall2 =>_imageSmall2;
  File get imageSmall3 =>_imageSmall3;
  File get imageSmall4 =>_imageSmall4;
  int get indexDelivery => _indexDelivery;
  int get indexItemType => _indexItemType;
  int get indexPayThrough => _indexPayThrough;
  String get itemName => _itemName;
  String get itemType => _itemType;
  List<File> get listImage => _listImage;
  String get information => _information;
  String get dateAuction => _dateAuction;
  String get timeAuction => _timeAuction;
  String get datetimeAuction => _datetimeAuction;
  String get place => _place;
  String get priceStart => _priceStart;
  String get priceSmallest => _priceSmallest;

  String get payThrough => _payThrough;
  String get bankName => _bankName;
  String get accountName => _accountName;
  String get accountNumber => _accountNumber;

  String get delivery => _delivery;
  String get placeDelivery => _placeDelivery;
  String get phoneNumber => _phoneNumber;
  String get moreDetail => _moreDetail;

  setImageBig(File imageBig){
  _imageBig = imageBig;
  notifyListeners();
  }

  setImageSmall1(File imageSmall1){
    _imageSmall1 = imageSmall1;
    notifyListeners();
  }

  setImageSmall2(File imageSmall2){
    _imageSmall2 = imageSmall2;
    notifyListeners();
  }

  setImageSmall3(File imageSmall3){
    _imageSmall3 = imageSmall3;
    notifyListeners();
  }

  setImageSmall4(File imageSmall4){
    _imageSmall4 = imageSmall4;
    notifyListeners();
  }

  setListImage(File listImage){
    _listImage.add(listImage);
    notifyListeners();
  }
  setDeleteListImage(File listImage){
    _listImage.removeWhere((file)=> file == listImage);
    notifyListeners();
  }

  setItemName(String itemName){
    _itemName = itemName;
    notifyListeners();
  }

  setItemType(String itemType,int indexItemType){
    _itemType = itemType;
    _indexItemType = indexItemType;
    notifyListeners();
  }

  setInformation(String information){
    _information = information;
    notifyListeners();
  }

  setDateAuction(String dateAuction){
    _dateAuction = dateAuction;
    notifyListeners();
  }

  setTimeAuction(String timeAuction){
    _timeAuction = timeAuction;
    notifyListeners();
  }

  setDateTimeAuction(String datetimeAuction){
    _datetimeAuction = datetimeAuction;
    notifyListeners();
  }

  setPlace(String place){
    _place = place;
    notifyListeners();
  }

  setPriceStart(String priceStart){
    _priceStart = priceStart;
    notifyListeners();
  }

  setPriceSmallest(String priceSmallest){
    _priceSmallest = priceSmallest;
    notifyListeners();
  }

  setPayThrough(String payThrough,int indexPayThrough){
    _payThrough = payThrough;
    _indexPayThrough = indexPayThrough;
    notifyListeners();
  }

  setBankName(String bankName){
    _bankName = bankName;
    notifyListeners();
  }

  setAccountName(String accountName){
    _accountName = accountName;
    notifyListeners();
  }

  setAccountNumber(String accountNumber){
    _accountNumber = accountNumber;
    notifyListeners();
  }

  setDelivery(String delivery,int indexDelivery){
    _delivery = delivery;
    _indexDelivery = indexDelivery;
    notifyListeners();

  }

  setPlaceDelivery(String placeDelivery){
    _placeDelivery = placeDelivery;
    notifyListeners();
  }

  setPhoneNumber(String phoneNumber){
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  setMoreDetail(String moreDetail){
    _moreDetail = moreDetail;
    notifyListeners();
  }



}