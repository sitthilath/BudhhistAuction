import 'package:buddhistauction/Provider/store_token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomProfileState();
  }
}

class _BottomProfileState extends State<BottomProfile> with AutomaticKeepAliveClientMixin {



   void showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text("ຍົກເລີກ"),
        onPressed:  () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = FlatButton(
        child: Text("ຕົກລົງ"),
        onPressed:  () {

        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("ອອກຈາກລະບົບ"),
        content: Text("ທ່ານຕ້ອງການອອກຈາກລະບົບ ຫຼື ບໍ່?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
  }
  @override
  Widget build(BuildContext context) {


    super.build(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.deepOrange,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(

        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ຂໍ້ມູນຂອງຂ້ອຍ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "/profile_user");
                },
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(24),
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    new AssetImage("asset/gif/loading.gif")))),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ປະຫວັດ ແລະ ຂໍ້ມູນສ່ວນຕົວ'),
                        Text(
                          'Name',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                    SizedBox(width: 20),

                  ],
                ),
              ),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              Text('ຂໍ້ມູນທີ່ຊື້',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20,),

              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                   Icon(Icons.work,color: Color.fromARGB(255, 184, 133, 13),),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ເຄື່ອງທີ່ຕິດຕາມ'),

                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                    SizedBox(width: 20),

                  ],
                ),
              ),
              Divider(),

              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Icon(Icons.favorite,color: Color.fromARGB(255, 184, 133, 13),),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ເຄື່ອງທີ່ມັກ'),

                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                    SizedBox(width: 20),

                  ],
                ),
              ),
              Divider(),

              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Icon(Icons.local_mall,color: Color.fromARGB(255, 184, 133, 13),),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ຖົງ'),

                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                    SizedBox(width: 20),

                  ],
                ),
              ),
              Divider(),

              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Icon(Icons.brightness_1,color: Color.fromARGB(255, 184, 133, 13),),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ເຄື່ອງທີ່ປະມູນຊະນະ'),

                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                    SizedBox(width: 20),

                  ],
                ),
              ),
              Divider(),

              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Icon(Icons.brightness_1,color: Color.fromARGB(255, 184, 133, 13),),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ເຄື່ອງທີ່ປະມູນເສຍ'),

                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                    SizedBox(width: 20),

                  ],
                ),
              ),

              Divider(),



              SizedBox(height: 20,),
              Text('ຂໍ້ມູນທີ່ປ່ອຍ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10,),

              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: ButtonTheme(
                  height: MediaQuery.of(context).size.width * 0.125,
                  minWidth: double.infinity,
                  child: RaisedButton(
                    color:Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.grey)),
                    onPressed: (){

                      Navigator.pushNamed(context,"/first_page");
                    },
                    child: Text(
                      'ປ່ອຍເຄື່ອງ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Icon(Icons.create,color: Color.fromARGB(255, 184, 133, 13),),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ຮ່າງ'),

                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                    SizedBox(width: 20),

                  ],
                ),
              ),
              Divider(),

              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Icon(Icons.add_shopping_cart,color: Color.fromARGB(255, 184, 133, 13),),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ເຄື່ອງທີ່ປ່ອຍຢູ່ດຽວນີ້'),

                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                    SizedBox(width: 20),

                  ],
                ),
              ),
              Divider(),

              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Icon(Icons.brightness_1,color: Color.fromARGB(255, 184, 133, 13),),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ເຄື່ອງທີ່ປ່ອຍໄດ້'),

                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                    SizedBox(width: 20),

                  ],
                ),
              ),
              Divider(),

              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Icon(Icons.brightness_1,color: Color.fromARGB(255, 184, 133, 13),),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ເຄື່ອງທີ່ປ່ອຍບໍ່ໄດ້'),

                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                    SizedBox(width: 20),

                  ],
                ),
              ),
              Divider(),
              InkWell(
                    onTap: (){
                      showAlertDialog(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout,color: Color.fromARGB(255, 184, 133, 13),),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ອອກຈາກລະບົບ'),

                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                        SizedBox(width: 20),

                      ],
                    ),
                  ),



            ],
          ),
        ),
      ),
    );


  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
