import 'dart:convert';
import 'dart:io';
import 'package:buddhistauction/Model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../const_api.dart';
import 'package:http/http.dart' as http;

class ProfileUser extends StatefulWidget {
  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  File _imageProfile;
  final picker = ImagePicker();


  List<User> _userList = new List<User>();


  /// Future Detail Buddhist/////////////////////////////////////////
  Future<List<User>> fetchUser() async {
    final response = await http.get("$API_URL/buddhist");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      _userList.clear();
      values = json.decode(response.body)['data'];

      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _userList.add(User.fromJson(map));

          }
        }
      }
      return _userList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load API');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ແກ້ໄຂໂປຣໄຟລ"),
      ),

      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imageSelected(),
                Text("ຊື່ແລະນາມສະກຸນ",style: TextStyle(fontFamily: 'boonhome',fontSize: 18),),
                Text("ເບີໂທ",style: TextStyle(fontFamily: 'boonhome',fontSize: 18),),
              ],
            ),
            Divider(indent: 10,
            endIndent: 10,),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ວັນເດືອນປີເກີດ",style: TextStyle(fontFamily: 'boonhome',fontSize: 18),),
                  Container(
                    width: double.infinity,


                    child: Card(
                        color: Colors.grey[100],

                        child: Text("7/12/2000",style: TextStyle(fontFamily: 'boonhome',fontSize: 18),)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),



    );

  }

  Widget imageSelected() {
    return

          GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child:
            CircleAvatar(
              radius: 90,
              backgroundImage: _imageProfile == null
                  ? NetworkImage("https://i.pinimg.com/originals/23/c5/e8/23c5e8abe1a2a341a6fc3e1a5656f3f5.jpg")
                  :  FileImage(_imageProfile),
            ),

    );
  }

  Future _imgFromCamera() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
         _imageProfile = File(pickedFile.path);

      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallery() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _imageProfile = File(pickedFile.path);

      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
