import 'dart:convert';

import 'package:buddhistauction/Argument/buddhist_argrument.dart';
import 'package:buddhistauction/Argument/commentID_argrument.dart';
import 'package:buddhistauction/Comment/utils.dart';
import 'package:buddhistauction/Provider/check_favorite_sharepref.dart';
import 'package:buddhistauction/const_api.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ContentDetail extends StatefulWidget {
  @override
  _ContentDetailState createState() => _ContentDetailState();
}

class _ContentDetailState extends State<ContentDetail> {
  final TextEditingController _msgTextController = new TextEditingController();



  bool _isLoading = false;

  Future<void> _takeUserDataFromFB() async {
    setState(() {
      _isLoading = true;
    });
  }

  Stream<Event> commentRealtime(int idBuddhist) {
    DatabaseReference _databaseReference = FirebaseDatabase.instance
        .reference()
        .child('Comments')
        .child('${idBuddhist.toString()}')
    ;

    return _databaseReference.onValue;
  }



  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BuddhistArguments args = ModalRoute.of(context).settings.arguments;


    return Scaffold(
        appBar: AppBar(
          title: Text('ຖາມຕອບ',style: TextStyle(fontFamily: 'boonhome',fontWeight: FontWeight.bold,fontSize: 18),),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: commentRealtime(args.buddhistItem[args.idx].id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final snapshotResult = snapshot.data.snapshot as DataSnapshot;
                final Map<dynamic, dynamic> values = snapshotResult.value;
                final List<String> _messages = [];
                final List<String> _dateTime = [];
                final List<String> _name = [];
                final List<int> _commentID = [];
                values.forEach((key, item) {
                  _messages.add(item['message']);
                  _dateTime.add(item['datetime']);
                  _name.add(item['name']);
                  _commentID.add(item['comment_id']);
                });

                return Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 6),

                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .all(8.0),
                                                    child: Icon(
                                                        Icons.book, size: 34),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [

                                                      Text(_name[0]),
                                                      Text(
                                                          Utils.readTimestamp(DateTime
                                                              .parse(
                                                              _dateTime[0])
                                                              .millisecondsSinceEpoch)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Center(child: ClipRRect(
                                                borderRadius: BorderRadius.circular(3.0),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: 'asset/gif/loading.gif',
                                                  image: "$Image_URL/"+args.buddhistItem[args.idx].image[0],
                                                  fit: BoxFit.fill,
                                                ),

                                              ),),
                                              SizedBox(height: 5,),
                                              Divider(height: 2,
                                                  color: Colors.grey),
                                              SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.mode_comment),
                                                  Text(
                                                    '  ຄວາມຄິດເຫັນ ( ${_messages
                                                        .length} )',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontFamily: 'boonhome'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            CommentList(name: _name, message: _messages, dateTime: _dateTime,commentID: _commentID,idBuddhist: args.buddhistItem[args.idx].id,),
                          ],


                        ),
                      ),
                    ),
                    _buildTextComposer(args.buddhistItem[args.idx].id)
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }



  Widget _buildTextComposer(int idBuddhist) {
    return new IconTheme(
      data: new IconThemeData(color: Theme
          .of(context)
          .accentColor),
      child: new Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
                child: TextField(
                  maxLines: 2,
                  controller: _msgTextController,

                  decoration: InputDecoration.collapsed(
                      hintText: "Write a message"),
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {

                  // _handleSubmitted(_msgTextController.text);
                  postComment(_msgTextController.text,idBuddhist,null);

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _handleSubmitted(String text) async {
  //
  //
  // }

  ///PostCommentToLaravel
  void postComment(String message,int id,String token) {
    String url = "$API_URL/buddhist/${id.toString()}/comment";
    http.post(url,
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiNWE2NDViNWU3OTE1NTU2NWU1NDJiNGY4OGFkYjA0NWEwMDc4NTQwOTMwNTBiMDg4YzgwMzY2OTUxNmJhMzhkZTA3ZWI2NGRhOTdlYWIwMjYiLCJpYXQiOjE2MTE3MjQ4NjksIm5iZiI6MTYxMTcyNDg2OSwiZXhwIjoxNjQzMjYwODY4LCJzdWIiOiIyNCIsInNjb3BlcyI6W119.cnEtpNwo3HoxeHmY5i_UsZToAkejc7gokKli1_vbbWvmUdbyqubiaYQs-OyDq3lbLifmmFMauRi-St56RMjRRZmgqlD_SLATi8XkXSviYy_ar05bXJ6G85gWzJkGIvIu46kvWEkaUk6hYt6VYV6CcWDrQo0HXUH2rChuMMqQBOL4IDP8sNC0ItdfV95hChSRXwpElEhL7cM1t9to1cNCa81biSnY-d0wu69KLJThQ3ZO_QiIXrUMxaufZUd9mWM6lqJ2WQlei_J1R0C17XdHmpiQgRy-tMIDfses5RfMe8igtOr1X7SKM0kYOm-Kdrl_yzMpQ660zF0xlRXe2zTXHSCYI8F6IXILzTM9eE1sg6DhLRjJahbbG_homBx1InghUPGwuvs2PgdFFu5BU9uRJAN97bse6CL1YPV6T7bqkRXgLbI8pxCltC0KJHmYj9lFUQXWt135lAvkqyJloIx3pGEpIimfEYo_tn7HFcASy-QhlmZRBHJ_TJw-lR7i6KF3gProRtWs1VqjqrBtFVhdaOn4TsshRrj99u7kDqLZh4TisuQsY3zEHc-IfEiKC_toPUTuw_wHSBNu5FoVqMTco02BP1SlTdDv4uuwncU9lRlhy8wbsthBVVwcSdDMI7Jh0Es7Am1-XMS6Ml7wAnZMviyQhAgzmkO89S354Dvsc3o',
        },
        body:{
          'message': message,

        })
        .then((response) {
      print('Response status : ${response.statusCode}');
      print('Response status : ${response.body}');


      if(response.statusCode == 200){
        print("OK");

      }else{
        print("error E Y WA");
      }

    }).catchError((e) {
      print("Error: $e");
    });
  }

}

class RepliesCount extends StatefulWidget {
  final int id;
  final int idBuddhist;

  RepliesCount({Key key, @required this.id, @required this.idBuddhist}):super(key: key);
  @override
  _RepliesCountState createState() => _RepliesCountState();
}

class _RepliesCountState extends State<RepliesCount> {
  Stream<Event> repliesRealtime() {
    DatabaseReference _databaseReference = FirebaseDatabase.instance
        .reference()
        .child('Comments')
        .child('${widget.idBuddhist}')
        .child('${widget.id}')
        .child('replies');
    return _databaseReference.onValue;
  }

  Stream<Event> noRepliesRealtime() {
    DatabaseReference _databaseReference = FirebaseDatabase.instance
        .reference()
        .child('Comments')
        .child('${widget.idBuddhist}');

    return _databaseReference.onValue;
  }
  @override
  void initState() {
    // TODO: implement initState
    print(repliesRealtime().length);
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: repliesRealtime(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snapshotResult = snapshot.data
                .snapshot as DataSnapshot;
            final Map<dynamic, dynamic> values = snapshotResult
                .value;


            final List<String> _repliesCount = [];
            values.forEach((key, item) {
              if(item['message'] == null){

              }else {
                _repliesCount.add(item['message']);
              }
            });
            return  Column(
              children: [

                GestureDetector(
                  onTap: (){  Navigator.pushNamed(context, "/listreplies",arguments: CommentIDArgrument(id: widget.id)); },
                  child: _repliesCount != null? Text(
                    "ຕອບກັບ (${_repliesCount.length})",
                    style: TextStyle(
                        fontFamily: 'boonhome',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ) : Text(
                    "ຕອບກັບ (0)",
                    style: TextStyle(
                        fontFamily: 'boonhome',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                ),
              ],
            )
            ;
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}


class CommentList extends StatefulWidget {
  final List<String> name;
  final List<String> message;
  final List<String> dateTime;
  final List<int> commentID;
  final int idBuddhist;
 const CommentList({Key key,@required this.idBuddhist,@required this.name,@required this.message,@required this.dateTime,@required this.commentID}): super(key:key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {


    return
      ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.message.length,
        itemBuilder: (context, index) {
          return
             widget.message.length > 0 ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
                child: Container(
                  width: 48,
                  height: 48,

                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlYq-pm0D3lvOwp8fldTae-fCi2lU3fy7AUQ&usqp=CAU"),
                  ),

                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.name[index]),
                          Text(
                            widget.message[index] + widget.idBuddhist.toString()
                               ,          maxLines: null,
                          ),
                        ],
                      ),
                    ),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Container(
                      width: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Text(Utils.readTimestamp(DateTime
                              .parse(widget.dateTime[index])
                              .millisecondsSinceEpoch)),
                          RepliesCount(id: widget.commentID[index],idBuddhist: widget.idBuddhist,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ) : Container();
        },


      );
  }


}
