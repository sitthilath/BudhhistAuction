import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNotification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomNotificationState();
  }
}

class _BottomNotificationState extends State<BottomNotification> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ແຈ້ງເຕືອນ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(

        child: Column(

          children: [
            Divider(),
            Expanded(
              child: SingleChildScrollView(

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1:30 PM',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1,
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Column(children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ມີຄົນສະເໜີລາຄາຫຼາຍກ່ວາ',
                                            style: TextStyle(
                                                color:
                                                Color.fromARGB(255, 134, 139, 128),
                                                fontSize: 12),
                                          ),
                                          Container(
                                            child: Row(children: [
                                              Container(
                                                child: Image.asset(
                                                  "asset/gif/loading.gif",
                                                  fit: BoxFit.fill,
                                                ),
                                                width:
                                                MediaQuery.of(context).size.width *
                                                    0.25,
                                                height:
                                                MediaQuery.of(context).size.width *
                                                    0.25,
                                              ),
                                              Container(
                                                margin:
                                                EdgeInsets.fromLTRB(10, 15, 0, 0),
                                                width:
                                                MediaQuery.of(context).size.width *
                                                    0.55,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'ພະສົມເດັດມະຫາເສດຖີ ລຸ້ນ 9',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'ປະມູນສູ້ບໍ່',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 134, 139, 128),
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      'ເພາະມີສະມາຊິກປະມູນໃນລາຄາ',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 134, 139, 128),
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      '250,000 Kip',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 134, 139, 128),
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ])),
                                ButtonTheme(
                                  height:MediaQuery.of(context).size.width *
                                      0.13,
                                  minWidth: double.infinity,
                                  child: FlatButton(
                                    color: Color.fromARGB(255, 62, 13, 184),
                                    onPressed: () {},
                                    child: Text(
                                      'ປະມູນ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1:30 PM',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1,
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Column(children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ມີຄົນສະເໜີລາຄາຫຼາຍກ່ວາ',
                                            style: TextStyle(
                                                color:
                                                Color.fromARGB(255, 134, 139, 128),
                                                fontSize: 12),
                                          ),
                                          Container(
                                            child: Row(children: [
                                              Container(
                                                child: Image.asset(
                                                  "asset/gif/loading.gif",
                                                  fit: BoxFit.fill,
                                                ),
                                                width:
                                                MediaQuery.of(context).size.width *
                                                    0.25,
                                                height:
                                                MediaQuery.of(context).size.width *
                                                    0.25,
                                              ),
                                              Container(
                                                margin:
                                                EdgeInsets.fromLTRB(10, 15, 0, 0),
                                                width:
                                                MediaQuery.of(context).size.width *
                                                    0.55,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'ພະສົມເດັດມະຫາເສດຖີ ລຸ້ນ 9',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'ປະມູນສູ້ບໍ່',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 134, 139, 128),
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      'ເພາະມີສະມາຊິກປະມູນໃນລາຄາ',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 134, 139, 128),
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      '250,000 Kip',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 134, 139, 128),
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ])),
                                ButtonTheme(
                                  height:MediaQuery.of(context).size.width *
                                      0.13,
                                  minWidth: double.infinity,
                                  child: FlatButton(
                                    color: Color.fromARGB(255, 62, 13, 184),
                                    onPressed: () {},
                                    child: Text(
                                      'ປະມູນ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1:30 PM',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1,
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Column(children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ມີຄົນສະເໜີລາຄາຫຼາຍກ່ວາ',
                                            style: TextStyle(
                                                color:
                                                    Color.fromARGB(255, 134, 139, 128),
                                                fontSize: 12),
                                          ),
                                          Container(
                                            child: Row(children: [
                                              Container(
                                                child: Image.asset(
                                                  "asset/gif/loading.gif",
                                                  fit: BoxFit.fill,
                                                ),
                                                width:
                                                    MediaQuery.of(context).size.width *
                                                        0.25,
                                                height:
                                                    MediaQuery.of(context).size.width *
                                                        0.25,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.fromLTRB(10, 15, 0, 0),
                                                width:
                                                    MediaQuery.of(context).size.width *
                                                        0.55,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'ພະສົມເດັດມະຫາເສດຖີ ລຸ້ນ 9',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'ປະມູນສູ້ບໍ່',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 134, 139, 128),
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      'ເພາະມີສະມາຊິກປະມູນໃນລາຄາ',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 134, 139, 128),
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      '250,000 Kip',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 134, 139, 128),
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ])),
                                ButtonTheme(
                                  height:MediaQuery.of(context).size.width *
                                      0.13,
                                  minWidth: double.infinity,
                                  child: FlatButton(
                                    color: Color.fromARGB(255, 62, 13, 184),
                                    onPressed: () {},
                                    child: Text(
                                      'ປະມູນ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
