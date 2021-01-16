import 'dart:convert';

BuddhistDetailType buddhistModelFromJson(String str) => BuddhistDetailType.fromJson(json.decode(str));

String buddhistModelToJson(BuddhistDetailType data) => json.encode(data.toJson());

class BuddhistDetailType {

  int id,time,type;
  String name,place,detail;
  int price;
  String image;

  BuddhistDetailType({this.id,this.time,this.name,this.price,this.type,this.detail,
   // this.place,
    this.image});

  factory BuddhistDetailType.fromJson(Map<String,dynamic> json)=> BuddhistDetailType(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    image: json['image_path'],
    detail: json['detail'],
   // place: json['place'],
    time: json['time_remain'],
    type: json['type_id'],
  );

  Map<String, dynamic> toJson() => {
    "id": this.id,
    "name": this.name,
    "price": this.price,
    "image_path": this.image,
    "detail" : this.detail,
    //"place": this.place,
    "time_remain":this.time,
    "type_id" : this.type,
  };

}