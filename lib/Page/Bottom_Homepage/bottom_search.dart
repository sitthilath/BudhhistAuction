import 'dart:async';
import 'dart:convert';
import 'package:buddhistauction/Argument/buddhist_agrument.dart';
import 'package:buddhistauction/Argument/buddhist_type_agrument.dart';
import 'package:buddhistauction/Filter/search_all.dart';
import 'package:buddhistauction/Model/buddhist_detail.dart';
import 'package:buddhistauction/Model/buddhist_type.dart';
import 'package:buddhistauction/Page/Time/time_convert.dart';
import 'package:buddhistauction/const_api.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:intl/intl.dart';



final currencyFormat = new NumberFormat("#,##0.00", "en_US");



class BottomSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomSearchState();
  }
}

class _BottomSearchState extends State<BottomSearch>
    with AutomaticKeepAliveClientMixin {

  List<BuddhistDetail> _buddhistList = new List<BuddhistDetail>();


  /// Future Detail Buddhist/////////////////////////////////////////
  Future<List<BuddhistDetail>> fetchBuddhist() async {
    final response = await http.get("$API_URL/buddhist");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      _buddhistList.clear();
      values = json.decode(response.body)['data'];

      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _buddhistList.add(BuddhistDetail.fromJson(map));

          }
        }
      }
      return _buddhistList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load API');
    }
  }


/// Future Type Buddhist/////////////////////////////////////////
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
      // If that call was not successful, throw an error.
      throw Exception('Failed to load API');
    }
  }



  @override
  void initState() {

    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [

                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ສະບາຍດີ !',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 184, 133, 13),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 15, 20),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      //border: Border.all(),

                      color: Color.fromARGB(255, 253, 243, 243),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                        hintText: "ຊອກຫາເຄື່ອງທັງໝົດ",
                        hintStyle: TextStyle(color: Colors.grey),
                        isDense: true,
                        // Added this
                        contentPadding: EdgeInsets.all(8),
                      ),
                      onTap: (){
                        showSearch(context: context, delegate: DataSearch(_buddhistList));
                      },
                    ),
                  ),

              buddhistType(),

              Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  Text(
                    "ໂປໂມຊັ້ນພິເສດ",
                    style: TextStyle(fontSize: 25),
                  ),
                  Spacer(),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/showallitem");
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "ເບິ່ງທັງໝົດ ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 184, 133, 13),
                              fontSize: 13,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 13,
                              color: Color.fromARGB(255, 184, 133, 13)),
                        ],
                      ))
                ],
              ),

              buddhistCardItemPopular(),

              //1111111111111111111111111111
              Row(
                children: [
                  Text(
                    "ລາຍການຍອດນິຍົມ",
                    style: TextStyle(fontSize: 25),
                  ),
                  Spacer(),
                  FlatButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "ເບິ່ງທັງໝົດ ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 184, 133, 13),
                              fontSize: 13,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 13,
                              color: Color.fromARGB(255, 184, 133, 13)),
                        ],
                      ))
                ],
              ),

              buddhistCardItemPopular(),
              //22222222222222222222222222222222222

              Row(
                children: [
                  Text(
                    "ໃກ້ໝົດເວລາປະມູນ",
                    style: TextStyle(fontSize: 25),
                  ),
                  Spacer(),
                  FlatButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "ເບິ່ງທັງໝົດ ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 184, 133, 13),
                              fontSize: 13,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 13,
                              color: Color.fromARGB(255, 184, 133, 13)),
                        ],
                      ))
                ],
              ),

              buddhistCardItemPopular(),
              //333333333333333333333333333333333
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  ///Widget Card Buddhist/////////////////////////////////////////////////////////////////
  Widget buddhistCardItemPopular() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: FutureBuilder<List<BuddhistDetail>>(
                future: fetchBuddhist(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _buddhistList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _CardItem(
                                cardItem: snapshot.data, index: index);
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

  ///Widget Card Buddhist/////////////////////////////////////////////////////////////


  ///Widget Type Buddhist/////////////////////////////////////////////////////////////////
  Widget buddhistType() {
    return Container(
      height: MediaQuery.of(context).size.height *0.15,

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
                            return Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: InkWell(
                                onTap: () {
                                Navigator.pushNamed(context, "/typelistitempage",arguments:BuddhistTypeArguments(id: _buddhistListType[index].id,name: _buddhistListType[index].name ));
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      child: Text(_buddhistListType[index].name,
                                      textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(_buddhistListType[index].name),
                                  ],
                                ),
                              ),

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

}



/// Class _CardItem ///////////////////////////////////////////////////////////////////////////
class _CardItem extends StatefulWidget {

  final List<BuddhistDetail> cardItem;
  final int index;

  const _CardItem({Key key, @required this.cardItem, @required this.index})
      : super(key: key);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<_CardItem> {
  String _timeUntil = 'Loading...';
  Timer _timer;
  var maxPrice;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    int remainTime = widget.cardItem[widget.index].time;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.mounted) {
        setState(() {
          _timeUntil = TimeConvert.timeLeft(remainTime);
          if (remainTime <= 0) {
            timer.cancel();
          }
          print("remain seconds: $remainTime");
          remainTime--;
        });
      }
    });
  }

  Stream<Event> priceRealtime(int id) {
    DatabaseReference _databaseReference = FirebaseDatabase.instance
        .reference()
        .child('buddhist')
        .child(id.toString());
    return _databaseReference.onValue;
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),

      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.of(context).pushNamed('/detailpage',
                arguments: BuddhistArguments(buddhistItem: widget.cardItem,idx: widget.index));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'asset/gif/loading.gif',
                    image: "$Image_URL/"+widget.cardItem[widget.index].image[0],
                    fit: BoxFit.fill,
                  ),

                ),

                Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'ວຽງຈັນ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Spacer(),
                          Text(
                            _timeUntil,
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.cardItem[widget.index].name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      StreamBuilder(
                        stream: priceRealtime(widget.cardItem[widget.index].id),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            final snapshotResult =
                                snapshot.data.snapshot as DataSnapshot;
                            final Map<dynamic, dynamic> values =
                                snapshotResult.value;
                            final List<int> _prices = [];
                            values.forEach((key, item) {
                              _prices.add(int.parse(item['price']));
                            });
                            maxPrice = _prices.reduce(math.max);
                            return Column(
                              children: [Text('${currencyFormat.format(maxPrice)}')],
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          // By default, show a loading spinner
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                      //Text("${widget.cardItem['price']}"),

                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


