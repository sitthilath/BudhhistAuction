
import 'package:buddhistauction/Argument/buddhist_argrument.dart';
import 'package:buddhistauction/Model/buddhist_detail.dart';
import 'package:buddhistauction/const_api.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'package:intl/intl.dart';
final currencyFormat = new NumberFormat("#,##0.00", "en_US");



class DataSearch extends SearchDelegate<List<BuddhistDetail>>{


  final List<BuddhistDetail> buddhist ;

  DataSearch(this.buddhist);





  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var maxPrice;
    Stream<Event> priceRealtime(int id) {
      DatabaseReference _databaseReference = FirebaseDatabase.instance
          .reference()
          .child('buddhist')
          .child(id.toString());
      return _databaseReference.onValue;
    }

    final List<BuddhistDetail>suggestionList = query.isEmpty ? [] : buddhist.where((data) => data.name.toLowerCase().contains(query)).toList();



    return suggestionList.isEmpty? Center(child: Text("ບໍ່ມີຂໍ້ມູນ",style: TextStyle(fontSize: 18),)) : ListView.builder(
      itemBuilder: (context,index){
        return Container(
          child: Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                Navigator.pushNamed(context, '/detailpage', arguments: BuddhistArguments(buddhistItem: buddhist,idx: index));
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
                                  image: "$Image_URL/"+suggestionList[index].image[0],
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
                                    '${suggestionList[index].time}',
                                    style: TextStyle(
                                        color:
                                        Colors.redAccent),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(suggestionList[index].name),

                              SizedBox(
                                height: 20,
                              ),

                              StreamBuilder(
                                stream: priceRealtime(suggestionList[index].id),
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
      },
      itemCount: suggestionList.length,
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
     final List<BuddhistDetail>suggestionList = query.isEmpty ? [] : buddhist.where((data) => data.name.toLowerCase().contains(query)).toList();

    return suggestionList.isEmpty? SizedBox() : ListView.builder(
      itemBuilder: (context,index){
       return ListTile(
          onTap: (){

            showResults(context);
          },
          leading: Icon(Icons.attribution_outlined),
          title: RichText(
            text:TextSpan(
                text:suggestionList[index].name.substring(0,query.length) ,
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                children: [TextSpan(
                    text: suggestionList[index].name.substring(query.length),
                    style: TextStyle(color:Colors.grey)
                )
                ]
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );

  }

}