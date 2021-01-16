

import 'dart:convert';

BuddhistType buddhistModelFromJson(String str) => BuddhistType.fromJson(json.decode(str));

String buddhistModelToJson(BuddhistType data) => json.encode(data.toJson());


class BuddhistType{
  int id;
  String name,image;


  BuddhistType({ this.id, this.name,this.image});

  factory BuddhistType.fromJson(Map<String,dynamic> json)=> BuddhistType(
    id: json['id'],
    name: json['name'],
    image: json['image'],

  );

  Map<String, dynamic> toJson() => {
    "id": this.id,
    "name": this.name,
    "image": this.image,

  };
}