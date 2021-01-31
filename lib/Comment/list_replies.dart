import 'package:buddhistauction/Argument/commentID_argrument.dart';
import 'package:buddhistauction/Comment/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListReplies extends StatefulWidget {

  @override
  _ListRepliesState createState() => _ListRepliesState();
}

class _ListRepliesState extends State<ListReplies> {

  final TextEditingController _msgTextController = new TextEditingController();


  Stream<Event> repliesRealtime(int id) {
    DatabaseReference _databaseReference = FirebaseDatabase.instance
        .reference()
        .child('Comments')
        .child('20')
        .child('${id.toString()}')
        .child('replies');
    return _databaseReference.onValue;
  }
  @override
  Widget build(BuildContext context) {
    final CommentIDArgrument args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: repliesRealtime(args.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snapshotResult = snapshot.data
                .snapshot as DataSnapshot;
            final Map<dynamic, dynamic> values = snapshotResult
                .value;

            final List<String> _message = [];
            final List<String> _dateTime = [];
            final List<String> _name = [];

            values.forEach((key, item) {
              _message.add(item['message']);
              _dateTime.add(item['datetime']);
              _name.add(item['name']);

            });
              return Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Column(

                  children: [
                    Expanded(child: RepliesList(name: _name,message: _message,dateTime: _dateTime)),
                    _buildTextComposer(),
                  ],
                ),
              );
          } else {
            return CircularProgressIndicator();
          }

        }
      ),
    );
  }


  Widget _buildTextComposer() {
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
                  onSubmitted: _handleSubmitted,
                  decoration: InputDecoration.collapsed(
                      hintText: "Write a message"),
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  setState(() {});
                  _handleSubmitted(_msgTextController.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _handleSubmitted(String text) async {}
}


class RepliesList extends StatefulWidget {
  final List<String> name;
  final List<String> message;
  final List<String> dateTime;
  final List<int> commentID;
  const RepliesList({Key key,@required this.name,@required this.message,@required this.dateTime,@required this.commentID}): super(key:key);

  @override
  _RepliesListState createState() => _RepliesListState();
}

class _RepliesListState extends State<RepliesList> {
  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.message.length,
        itemBuilder: (context, index) {
          return Row(
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
                            widget.message[index] +
                                "doifjdsjejcijcpijsnjljfdoifjdsjejcijcpijsnjljfdoifjdsjejcijcpijsnjljfdoifjdsjejcijcpijsnjljfdoifjdsjejcijcpijsnjljfdoifjdsjejcijcpijsnjljfdoifjdsjejcijcpijsnjljfd",
                            maxLines: null,
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

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },


      );
  }


}