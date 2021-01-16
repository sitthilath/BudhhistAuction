import 'dart:convert';

import 'package:buddhistauction/Argument/buddhist_type_agrument.dart';

import 'package:buddhistauction/Model/buddhist_type_id.dart';
import 'package:buddhistauction/const_api.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:intl/intl.dart';

final currencyFormat = new NumberFormat("#,##0.00", "en_US");

class TypeListItemPage extends StatefulWidget {
  @override
  _TypeListItemPageState createState() => _TypeListItemPageState();
}

class _TypeListItemPageState extends State<TypeListItemPage> {


  List<BuddhistDetailType> _buddhistList = new List<BuddhistDetailType>();


  Future<List<BuddhistDetailType>> fetchBuddhist(String id) async {
    final response = await http.get("$API_URL/typeBuddhist/"+id);

    if (response.statusCode == 200) {
      print("dai");
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      _buddhistList.clear();
      values = json.decode(response.body)['data'];
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _buddhistList.add(BuddhistDetailType.fromJson(map));
          }
        }
      }
      return _buddhistList;
    }
    else{
      print("br dai");
      // If that call was not successful, throw an error.
      throw Exception('Failed to load API');
    }
  }

  var maxPrice;

  Stream<Event> priceRealtime(int id) {
    DatabaseReference _databaseReference = FirebaseDatabase.instance
        .reference()
        .child('buddhist')
        .child(id.toString());
    return _databaseReference.onValue;
  }

  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    final BuddhistTypeArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("${args.name}"),

      ),
      body: SafeArea(
        child: FutureBuilder<List<BuddhistDetailType>>(
            future: fetchBuddhist(args.id.toString()),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Card(
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                Navigator.pushNamed(context, '/detailpage');
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              child: Center(
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'asset/gif/loading.gif',
                                                  image: _buddhistList[index].image[0],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'ວຽງຈັນ',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    '3ມື້',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.redAccent),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(_buddhistList[index].name),

                                              SizedBox(
                                                height: 20,
                                              ),

                                              StreamBuilder(
                                                stream: priceRealtime(_buddhistList[index].id),
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
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
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
    );
  }
}
