class User{

  String name,surname,dateOfBirth,phoneNumber;

  User({this.name,this.surname,this.dateOfBirth,this.phoneNumber});

  factory User.fromJson(Map<String,dynamic> json)=> User(

    name: json['name'],
    surname : json['surname'],
    dateOfBirth: json['dateOfBirth'],
    phoneNumber: json['phoneNumber'],

  );

  Map<String, dynamic> toJson() => {
    "name": this.name,
    "surname": this.surname,
    "dateOfBirth": this.dateOfBirth,
    "phoneNumber" : this.phoneNumber,

  };
}