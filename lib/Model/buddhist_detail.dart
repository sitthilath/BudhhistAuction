import 'dart:convert';

BuddhistDetail buddhistModelFromJson(String str) => BuddhistDetail.fromJson(json.decode(str));

String buddhistModelToJson(BuddhistDetail data) => json.encode(data.toJson());

class BuddhistDetail {

  int id,time;
  String name,place,type,detail;
  int price;
  List<String> image;

  BuddhistDetail({this.id,this.time,this.name,this.price,this.type,this.detail,this.place,this.image});

  factory BuddhistDetail.fromJson(Map<String,dynamic> json)=> BuddhistDetail(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    image: List.from(json['image'].map((x)=> x.toString())),
    detail: json['detail'],
    place: json['place'],
    time: json['time_remain'],
    type: json['type_id'],
  );

  Map<String, dynamic> toJson() => {
    "id": this.id,
    "name": this.name,
    "price": this.price,
    "image": List<dynamic>.from(image.map((x) => x.toString())),
    "detail" : this.detail,
    "place": this.place,
    "time_remain":this.time,
    "type_id" : this.type,
  };

}