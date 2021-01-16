import 'dart:convert';
import 'dart:io';

import 'package:buddhistauction/Model/buddhist_type.dart';
import 'package:buddhistauction/Page/ReleaseBuddhist/second_page.dart';
import 'package:buddhistauction/Provider/store_release_buddhist.dart';

import 'package:buddhistauction/TransitionPageRoute/slide_left_right.dart';
import 'package:buddhistauction/const_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var _key = GlobalKey<FormState>();

  File _imageBig, _imageSmall1, _imageSmall2, _imageSmall3, _imageSmall4;
  final List<File> listImage = [];
  final picker = ImagePicker();
  bool isSelected = true;
  int _value;
  TextEditingController _nameBuddhist = new TextEditingController();


  List<BuddhistType> _buddhistListType = new List<BuddhistType>();

  Future<List<BuddhistType>> fetchBuddhistType() async {
    final response = await http.get("$API_URL/type");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> value = new List<dynamic>();
      _buddhistListType.clear();
      value = json.decode(response.body)['data'];

      if (value.length > 0) {
        for (int i = 0; i < value.length; i++) {
          if (value[i] != null) {
            Map<String, dynamic> map = value[i];
            _buddhistListType.add(BuddhistType.fromJson(map));
          }
        }
      }
      return _buddhistListType;
    } else {
      throw Exception('Failed to load API');
    }
  }

  @override
  Widget build(BuildContext context) {
  _imageBig = Provider.of<StoreReleaseBuddhist>(context,listen:false).imageBig;
  _imageSmall1 = Provider.of<StoreReleaseBuddhist>(context,listen:false).imageSmall1;
  _imageSmall2 = Provider.of<StoreReleaseBuddhist>(context,listen:false).imageSmall2;
  _imageSmall3 = Provider.of<StoreReleaseBuddhist>(context,listen:false).imageSmall3;
  _imageSmall4 = Provider.of<StoreReleaseBuddhist>(context,listen:false).imageSmall4;


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ປ່ອຍເຄື່ອງ",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'boonhome'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                imageSelectedBig(),
                SizedBox(
                  height: 32,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ລົງຮູບໄດ້ອີກ 4 ຮູບ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'boonhome'),
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    imageSelectedSmall1(),
                    SizedBox(
                      width: 20,
                    ),
                    imageSelectedSmall2(),
                    SizedBox(
                      width: 20,
                    ),
                    imageSelectedSmall3(),
                    SizedBox(
                      width: 20,
                    ),
                    imageSelectedSmall4(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ຊື່ເຄື່ອງ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'boonhome'),
                    )),
                SizedBox(
                  height: 10,
                ),
                Consumer<StoreReleaseBuddhist>(

                  builder: (context, srb, child) {
                    if (_nameBuddhist.text != srb.itemName) {
                      // Or check if appState.username != null or what ever your use case is.
                      _nameBuddhist.text = srb.itemName ?? '';
                    }

                    return TextFormField(
                      controller: _nameBuddhist,
                      onChanged: (value) {
                        srb.setItemName(value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'ກະລຸນາປ້ອນຂໍ້ມູນ';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ແທັກປະເພດ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'boonhome'),
                    )),
                buddhistType(),
                SizedBox(
                  height: 20,
                ),
                submitButton(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 80.0,
          child: numberPage(),
        ),
      ),
    );
  }

  ///------------------num 1 2 3 4
  Widget numberPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 62, 13, 184),
                  child: Text("1",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'boonhome')),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("ລົງຮູບ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'boonhome')),
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                alignment: Alignment.topCenter,
                child: Text(
                  ". . . .",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 253, 200, 200),
                  child: Text("2",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'boonhome')),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("ຂໍ້ມູນ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 253, 200, 200),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'boonhome')),
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                alignment: Alignment.topCenter,
                child: Text(
                  ". . . .",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 253, 200, 200),
                  child: Text("3",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'boonhome')),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("ລາຄາ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 253, 200, 200),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'boonhome')),
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                alignment: Alignment.topCenter,
                child: Text(
                  ". . . .",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 253, 200, 200),
                  child: Text("4",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'boonhome')),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("ຈັດສົ່ງ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 253, 200, 200),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'boonhome')),
              ],
            ),
          ],
        ),
      ],
    );
  }

  ///Widget Type Buddhist/////////////////////////////////////////////////////////////////
  Widget buddhistType() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.10,
      child: Row(
        children: [
          Expanded(
            child: FutureBuilder<List<BuddhistType>>(
                future: fetchBuddhistType(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _buddhistListType.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Consumer<StoreReleaseBuddhist>(
                              builder: (context, srb, child) {
                                if (_value != srb.indexItemType) {
                                  // Or check if appState.username != null or what ever your use case is.
                                  _value = srb.indexItemType ?? '';
                                }
                                return Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: ChoiceChip(
                                    backgroundColor:
                                    Color.fromARGB(255, 253, 200, 200),
                                    selectedColor:
                                    Color.fromARGB(255, 62, 13, 184),
                                    labelStyle: _value == index
                                        ? TextStyle(color: Colors.white)
                                        : TextStyle(color: Colors.black),
                                    label: Text(
                                        '${_buddhistListType[index].name}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'boonhome')),
                                    selected: _value == index,
                                    onSelected: (bool selected) {
                                      srb.setItemType(
                                          _buddhistListType[index].name,index);
                                      setState(() {
                                        _value = selected ? index : null;
                                      });
                                      print(_buddhistListType[index].name);
                                    },
                                    //  selectedColor: isSelected ? Colors.black : Colors.white
                                  ),
                                );
                              },
                            );
                          }),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }

  ///Widget Type Buddhist/////////////////////////////////////////////////////////////

  ///Widget SelectImage All--------------------------------------------------------------

  Widget imageSelectedBig() {
    return Center(
      child: Stack(
        children: [

            _imageBig != null
                ?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      _imageBig,
                      width: 100,
                      height: 90,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )
                :
    GestureDetector(
      onTap: () {
        _showPickerBig(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.red,
        ),
        width: 100,
        height: 90,
        child: Icon(
          Icons.add_photo_alternate_outlined,
          color: Colors.white,
          size: 40,
        ),
      ),
    ),
          _imageBig != null
              ? _imageSmall1 == null ?
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              maxRadius: 10,
              child: GestureDetector(
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 18,
                ),
                onTap: () {
                  setState(() {
                    Provider.of<StoreReleaseBuddhist>(context,
                        listen: false)
                        .setDeleteListImage(_imageBig);
                    _imageBig = null;
                    Provider.of<StoreReleaseBuddhist>(context, listen: false)
                        .setImageBig(_imageBig);
                  });
                },
              ),
            ),
          ) : SizedBox()
              : SizedBox()
        ],
      ),
    );
  }

  Widget imageSelectedSmall1() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(children: [
         _imageSmall1 != null
              ?
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      _imageSmall1,
                      width: 60,
                      height: 50,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )

              : GestureDetector(
           onTap: () {
             _showPickerSmall1(context);
           },
           child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.red,
            ),
            width: 60,
            height: 50,
            child: Icon(
              Icons.add_photo_alternate_outlined,
              color: Colors.white,
            ),
          ),
        ),
        _imageSmall1 != null
            ? _imageSmall2 == null ?
        Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            maxRadius: 8,
            child: GestureDetector(
              child: Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: 14,
              ),
              onTap: () {
                setState(() {
                  Provider.of<StoreReleaseBuddhist>(context, listen: false)
                      .setDeleteListImage(_imageSmall1);
                  _imageSmall1 = null;
                  Provider.of<StoreReleaseBuddhist>(context, listen: false)
                      .setImageSmall1(_imageSmall1);
                });
              },
            ),
          ),
        ) : SizedBox()
            : _imageBig == null
            ? Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color.fromARGB(255, 253, 220, 220),
          ),
          width: 60,
          height: 50,
        )
            : SizedBox()
      ]),
    );
  }

  Widget imageSelectedSmall2() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(children: [
         _imageSmall2 != null
              ?
               Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    _imageSmall2,
                    width: 60,
                    height: 50,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
              : GestureDetector(
           onTap: () {
             _showPickerSmall2(context);
           },
           child:Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.red,
            ),
            width: 60,
            height: 50,
            child: Icon(
              Icons.add_photo_alternate_outlined,
              color: Colors.white,
            ),
          ),
        ),
        _imageSmall2 != null
            ? _imageSmall3 == null ?
        Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            maxRadius: 8,
            child: GestureDetector(
              child: Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: 14,
              ),
              onTap: () {
                setState(() {
                  Provider.of<StoreReleaseBuddhist>(context, listen: false)
                      .setDeleteListImage(_imageSmall2);
                  _imageSmall2 = null;
                  Provider.of<StoreReleaseBuddhist>(context, listen: false)
                      .setImageSmall2(_imageSmall2);
                });
              },
            ),
          ),
        ) : SizedBox()
            : _imageSmall1 == null
            ? Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color.fromARGB(255, 253, 220, 220),
          ),
          width: 60,
          height: 50,
        )
            : SizedBox()
      ]),
    );
  }

  Widget imageSelectedSmall3() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(children: [
         _imageSmall3 != null
              ?  Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    _imageSmall3,
                    width: 60,
                    height: 50,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
              : GestureDetector(
           onTap: () {
             _showPickerSmall3(context);
           },
           child:Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.red,
            ),
            width: 60,
            height: 50,
            child: Icon(
              Icons.add_photo_alternate_outlined,
              color: Colors.white,
            ),
          ),
        ),
        _imageSmall3 != null
            ? _imageSmall4 == null ?
        Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            maxRadius: 8,
            child: GestureDetector(
              child: Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: 14,
              ),
              onTap: () {
                setState(() {
                  Provider.of<StoreReleaseBuddhist>(context, listen: false)
                      .setDeleteListImage(_imageSmall3);
                  _imageSmall3 = null;
                  Provider.of<StoreReleaseBuddhist>(context, listen: false)
                      .setImageSmall3(_imageSmall3);
                });
              },
            ),
          ),
        ) : SizedBox()
            : _imageSmall2 == null
            ? Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color.fromARGB(255, 253, 220, 220),
          ),
          width: 60,
          height: 50,
        )
            : SizedBox()
      ]),
    );
  }

  Widget imageSelectedSmall4() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
           _imageSmall4 != null
                ?  Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      _imageSmall4,
                      width: 60,
                      height: 50,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )
                : GestureDetector(
             onTap: () {
               _showPickerSmall4(context);
             },
             child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.red,
              ),
              width: 60,
              height: 50,
              child: Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.white,
              ),
            ),
          ),
          _imageSmall4 != null
              ? Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              maxRadius: 8,
              child: GestureDetector(
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 14,
                ),
                onTap: () {
                  setState(() {
                    Provider.of<StoreReleaseBuddhist>(context, listen: false)
                        .setDeleteListImage(_imageSmall4);
                    _imageSmall4 = null;
                    Provider.of<StoreReleaseBuddhist>(context, listen: false)
                        .setImageSmall4(_imageSmall4);
                  });
                },
              ),
            ),
          )
              : _imageSmall3 == null
              ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color.fromARGB(255, 253, 220, 220),
            ),
            width: 60,
            height: 50,
          )
              : SizedBox()
        ],
      ),
    );
  }

  ///End Widget return/////////////////////////////////////////////////////////

  /// Method PickerImage---------------------------------------------------

  Future _imgFromCameraBig() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
       // _imageBig = File(pickedFile.path);
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setListImage(File(pickedFile.path));
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setImageBig(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGalleryBig() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        //_imageBig = File(pickedFile.path);
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setListImage(File(pickedFile.path));
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setImageBig(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromCameraSmall1() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        //_imageSmall1 = File(pickedFile.path);
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setListImage(File(pickedFile.path));
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setImageSmall1(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallerySmall1() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
       // _imageSmall1 = File(pickedFile.path);
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setListImage(File(pickedFile.path));
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setImageSmall1(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromCameraSmall2() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        //_imageSmall2 = File(pickedFile.path);
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setListImage(File(pickedFile.path));
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setImageSmall2(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallerySmall2() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
       // _imageSmall2 = File(pickedFile.path);
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setListImage(File(pickedFile.path));
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setImageSmall2(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromCameraSmall3() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        //_imageSmall3 = File(pickedFile.path);
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setListImage(File(pickedFile.path));
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setImageSmall3(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallerySmall3() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        //_imageSmall3 = File(pickedFile.path);
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setListImage(File(pickedFile.path));
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setImageSmall3(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromCameraSmall4() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
       // _imageSmall4 = File(pickedFile.path);
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setListImage(File(pickedFile.path));
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setImageSmall4(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallerySmall4() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
       // _imageSmall4 = File(pickedFile.path);
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setListImage(File(pickedFile.path));
        Provider.of<StoreReleaseBuddhist>(context, listen: false)
            .setImageSmall4(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  ///End Method PickerImage///////////////////////////////////////////////////

  ///-------------------ShowPickerBig Widget
  void _showPickerBig(context) {
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
                        _imgFromGalleryBig();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCameraBig();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///-------------------ShowPickerSmall1 Widget
  void _showPickerSmall1(context) {
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
                        _imgFromGallerySmall1();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCameraSmall1();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///-------------------ShowPickerSmall2 Widget
  void _showPickerSmall2(context) {
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
                        _imgFromGallerySmall2();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCameraSmall2();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///-------------------ShowPickerSmall3 Widget
  void _showPickerSmall3(context) {
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
                        _imgFromGallerySmall3();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCameraSmall3();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///-------------------ShowPickerSmall4 Widget
  void _showPickerSmall4(context) {
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
                        _imgFromGallerySmall4();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCameraSmall4();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///-------------------submitButton Widget
  Widget submitButton() {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 40,
      child: RaisedButton(
        color: Color.fromARGB(255, 62, 13, 184),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          'ຕໍ່ໄປ',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (_key.currentState.validate()) {
            _key.currentState.save();

            var buddhistType = Provider.of<StoreReleaseBuddhist>(context,listen: false).itemType;
            if (_imageBig == null) {
              Fluttertoast.showToast(
                  msg: "ກະລຸນາເພີ່ມຮູບ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if(buddhistType == null){
              Fluttertoast.showToast(
                  msg: "ກະລຸນາເລືອກປະເພດ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            else {
              Navigator.push(context, SlideRightRoute(page: SecondPage()));
            }
          } else {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Processing Data')));
          }
        },
      ),
    );
  }
}
