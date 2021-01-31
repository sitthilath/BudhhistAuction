
import 'package:buddhistauction/Argument/buddhist_argrument.dart';
import 'package:buddhistauction/Model/buddhist_detail.dart';
import 'package:buddhistauction/Provider/check_favorite_sharepref.dart';
import 'package:buddhistauction/Provider/provider_sharepreference_showbottom.dart';
import 'package:buddhistauction/const_api.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

final currencyFormat = new NumberFormat("#,##0.00", "en_US");



class DetailPage extends StatefulWidget {

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final ref = FirebaseDatabase.instance.reference();
  var maxPrice;
   Stream<Event> priceRealtime(int id) {
     DatabaseReference _databaseReference = FirebaseDatabase.instance.reference()
     .child('buddhist')
        .child(id.toString());
    return _databaseReference.onValue;
  }

  Stream<Event> userAuctionRealtime(int id) {
    DatabaseReference _databaseReference = FirebaseDatabase.instance.reference()
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
    final BuddhistArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.deepOrange,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                  background: Swiper(
                    itemCount: args.buddhistItem[args.idx].image.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Image.network(
                          "$Image_URL/"+args.buddhistItem[args.idx].image[index],
                          fit: BoxFit.fill,
                        ),
                    autoplay: true,
                    pagination: SwiperPagination(),
                  )),
              actions: [
                // IconButton(
                //   icon: Icon(Icons.shopping_basket,
                //       color: Colors.white, size: 30),
                //   onPressed: () {
                //     print("kod leo");
                //   },
                // ),
                Consumer<Favorite>(
                    builder: (context, value, child){
                      return FavoriteButton(

                        isFavorite: value.checkFavorite,
                        valueChanged: (_isFavorite) {
                          if(_isFavorite ==true){
                            print("ok");

                          }else{
                            print("not");

                          }
                          value.toggleFavorite();
                          print('Is Favorite : $_isFavorite');
                        },
                      );
                    }

                ),
              ],
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: Navigator.of(context).pop,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          args.buddhistItem[args.idx].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: StreamBuilder(
                          stream: priceRealtime(args.buddhistItem[args.idx].id),
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
                                children: [Text('${currencyFormat.format(maxPrice)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Colors.grey,fontSize: 30,fontFamily: 'boonhome'),

                                )],
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }

                            // By default, show a loading spinner
                            return Center(child: CircularProgressIndicator());
                          },
                        ),

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: ButtonTheme(
                          height: MediaQuery.of(context).size.width * 0.13,
                          minWidth: double.infinity,
                          child: FlatButton(
                            color: Color.fromARGB(255, 62, 13, 184),
                            onPressed: () {

                              //_showModalBottomSheet(context);
 /// ShowModalBottomSheet----------------------------------------------------------------------
                              showModalBottomSheet<void>(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomSheetItem(buddhistList: args.buddhistItem,index: args.idx,);
                                },
                              );

  /// ShowModalBottomSheet----------------------------------------------------------------------
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'ປະມູນ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'ປິດປະມູນ:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'ວັນທີ 14 ເດືອນ 8 ເວລາ 9:00 ເເລງ ມີ 98 ຄົນທີ່ຕິດຕາມສິນຄ້າ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Container(
                                      child: StreamBuilder(
                                        stream: userAuctionRealtime(args.buddhistItem[args.idx].id),
                                        builder:
                                            (BuildContext context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            final snapshotResult =
                                            snapshot.data.snapshot as DataSnapshot;
                                            final Map<dynamic, dynamic> values =
                                                snapshotResult.value;
                                            final List<String> _users = [];

                                            values.forEach((key, item) {
                                              if(_users.contains(item['uid'])){
                                                print("exist");
                                              }else{
                                                _users.add(item['uid']);
                                                  print(_users.toList());
                                              }

                                            });

                                            return Column(
                                              children: [Text('${_users.length-1}'
                                              + ' ຄົນປະມູນ',
                                              style: TextStyle(
                                                color: Colors.indigo,
                                              ),),
                                              ],);
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          }

                                          // By default, show a loading spinner
                                          return Center(child: CircularProgressIndicator());
                                        },
                                      ),

                                    ),

                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ລາຍລະອຽດ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ສະພາບ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ໃໝ່',
                            style: TextStyle(fontSize: 16),
                          )),
                      Divider(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ລາຍລະອຽດ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ເປີດປະມູນແບ່ງປັນຫລຽນພຣະຄຣູອະນາວິໂຣ(ຊາໂງນ)ເມືອງ ໂພນທອງ ແຂວງ ຈຳປາສັກ🛎ເປີດ40.000ເຄາະຕາມສັຕທາ⏰ປິດ9:00 ເເລງ ຜູ້ຊະນະເທິງຄຳວ່າ"ປິດ"ຕ່າງແຂວງບວກຄ່າສົ່ງ🚛🚛🚛',
                            style: TextStyle(fontSize: 16),
                          )),
                      Divider(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ຈັດສົ່ງ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ສາມາດຈັດເເຈງກັບຜູ້ຂາຍໄດ້',
                            style: TextStyle(fontSize: 16),
                          )),
                      Divider(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ຮັບສິນຄ້າດ້ວຍຕົວເອງ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ມີ',
                            style: TextStyle(fontSize: 16),
                          )),
                      Divider(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ຮັບສິນຄ້າດ້ວຍຕົວເອງ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ເງິນສົດ',
                            style: TextStyle(fontSize: 16),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ໂອນເງິນ',
                            style: TextStyle(fontSize: 16),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'BCEL One',
                            style: TextStyle(fontSize: 16),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'M Money',
                            style: TextStyle(fontSize: 16),
                          )),
                      Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/content_detail',arguments: BuddhistArguments(buddhistItem: args.buddhistItem,idx: args.idx));

                        },
                        child: Row(
                          children: [
                            Icon(Icons.brightness_1),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ຄໍາຖາມ ເເລະ ຄໍາຕອບ'),
                                Text(
                                  '5 ຄໍາຖາມ',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                      Divider(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ກ່ຽວກັບຜູ້ປ່ອຍ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(24),
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new AssetImage(
                                            "asset/gif/loading.gif")))),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name (52 \U+0E838)  '),
                                Text(
                                  'ວຽງຈັນ',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(Icons.brightness_1,
                                color: Color.fromARGB(255, 184, 133, 13)),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ຄຳຄິດເຫັນ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                Text(
                                  '99% ຄົນພໍໃຈ',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(Icons.local_mall,
                                color: Color.fromARGB(255, 184, 133, 13)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'ສີນຄ້າອື່ນໆທີ່ຜູ້ຂາຍກໍາລັງປ່ອຍ',
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(Icons.change_history,
                                color: Color.fromARGB(255, 184, 133, 13)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'ລາຍງານສີນຄ້ານີ້',
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                      Divider(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ສີນຄ້າອື່ນໆເຈົ້າໜ້າຈະສົນໃຈ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Card(
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      print('Card tapped.');
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              "asset/gif/loading.gif",
                                              fit: BoxFit.fill,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(8),
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
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                      'ພະສົມເດັດມະຫາເສດຖີ ລຸ້ນ 9'),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text('250,000 Kip'),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}


///BottomSheet/////////////////////////////////////////////////////////////////////
class BottomSheetItem extends StatefulWidget {
  final List<BuddhistDetail> buddhistList;
  final int index;

  const BottomSheetItem({Key key, @required this.buddhistList,@required this.index}): super(key:key);

  @override
  _BottomSheetItemState createState() => _BottomSheetItemState();
}

class _BottomSheetItemState extends State<BottomSheetItem> {

  final priceController = TextEditingController();

  final String token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiYjUwMDAyOTFhYTZhNmFmMzA0YjA2NjRhMjJkNjdkNmM0MDlhNzEyNGU4YWVkNjE1ODE1MTA3ZDgxN2VjNjczNzJhOTkwNGRiOTUxNWNkNTYiLCJpYXQiOjE2MDc2NzI0NTIsIm5iZiI6MTYwNzY3MjQ1MiwiZXhwIjoxNjM5MjA4NDUyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.cDsEdLH0wtbkxxmOuEJbp4NxdAD-74aknFxmz6oLJy0SOqXkNvGGWQLUmJZ5Ss9H7jmpekmleNrVMPGjrrzanbu-4WT3kjXoSeKfOV0vD--0_DpqixnRI65kVD5coNUpELsoBiRXHNhhfyAvcZxOMuO55YCpk_uMj2m1i9LR37hF4mGvr4Uoc-SmxE60s_5NrAWv9P-gQlGsv95NSAJU7INqYFDYuxtoTgmR9BwPqGoJDEngfafgBPU0OgBPqn1JCKFb1yQAxsi_q4tSryGJe214mnKLQExlZemAm5cdD7DjJzWGZTbvjY1ZdlvuA-wLEtogpO0zp_A6elZayXseX0dQ-DpXfYtDJl0au6UiZrHbwxslpCT_068Blts8JVIDFQTQMdxyO8bTlHD-8wmiivqiWtD4R_RREcZ4cxUX8Y6HWlKnMSzVmIr0K3fIPtU2FMR0jJEGiLQREBNG7kjBhzgd19fymqqOTlspj4wIP733a5eyh_klqZFgBv_cBq61hrQkthC6tc-dEHdfz7jcHmY793RkrVBTb6uwSHEPYToXeUB3bfpgtkKJwgJaRly-D3ZFJOFeA2ZQ-Jun8j2520ZFW8GUYb8PthEz0z4-P_NneOezT9Ouhvbp9ITpCgJZN3SzCrTi8QfLqEhjP91eP-XQOFW6ORa5xR8lw6VxHOw";
  void insertData(int price,int id){

    String url = "$API_URL/bidding/"+id.toString();
    http.post( url,

        headers: {        'Accept' : 'application/json; charset=UTF-8',
          'Authorization' : token,
        },
        body: {
          'bidding_price': '$price',

        }).then((response){
      print('Response status : ${response.statusCode}');
      print('Response status : ${response.body}');

    });
  }

  Stream<Event> priceRealtime(int id) {
    DatabaseReference _databaseReference = FirebaseDatabase.instance
        .reference()
        .child('buddhist')
        .child(id.toString());
    return _databaseReference.onValue;
  }

  var maxPrice;


  void showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("ຍົກເລີກ"),
      onPressed:  () {},
    );
    Widget continueButton = FlatButton(
      child: Text("ຕົກລົງ"),
      onPressed:  () {
        insertData(int.parse(priceController.text),widget.buddhistList[widget.index].id);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ປະມູນ"),
      content: Text("ທ່ານຕ້ອງການປະມູນ ຫຼື ບໍ່?"),
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

    return Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
              topLeft:
              const Radius.circular(10.0),
              topRight:
              const Radius.circular(10.0))),
      height: MediaQuery.of(context).size.height *
          0.9,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'ຍົກເລີກ',
                    style: TextStyle(
                        fontFamily: 'lao',
                        color: Color.fromARGB(
                            255, 62, 13, 184),
                        fontSize: 20.0,
                        fontWeight:
                        FontWeight.bold),
                  ),
                  onPressed: () =>
                      Navigator.pop(context),
                ),
                Text(
                  'ລາຍການປະມູນ',
                  style: TextStyle(
                      fontFamily: 'lao',
                      fontSize: 25.0,
                      fontWeight:
                      FontWeight.bold),
                ),
                FlatButton(
                  child: Text(
                    'ປະມູນ',
                    style: TextStyle(
                        fontFamily: 'lao',
                        fontSize: 20.0,
                        color: Color.fromARGB(
                            255, 62, 13, 184),
                        fontWeight:
                        FontWeight.bold),
                  ),
                  onPressed: () {

                    showAlertDialog(context);

                  },
                ),
              ],
            ),
            Divider(),

            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    'ພຣະຄຣູອະນາວິໂຣ(ຊາໂງນ)',
                    style: TextStyle(
                      color: Color.fromARGB(
                          255, 23, 23, 23),
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                'ປະມູນ',
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'ສ່ອງທາງການຈ່າຍເງີນ:ເງີນສົດ,ເງີນໂອນ,Bcel one ',
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text(
                  'ລາຄາສະເໜີດງວນີ້ ',
                ),
                Spacer(),

                StreamBuilder(
                  stream: priceRealtime(widget.buddhistList[widget.index].id),
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
                        children: [Text('${currencyFormat.format(maxPrice)}',
                        style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(
                        255, 134, 139, 128)),)],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner
                    return Center(child: CircularProgressIndicator());
                  },
                ),

                Icon(
                  Icons.outlined_flag,
                  color: Colors.orange,
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(),

            //autopamoon


            Divider(),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                  hintText:
                  'ລາຄາປະມູນທີ່ເຈົ້າໃສ່'),
              keyboardType:
              TextInputType.number,
            ),
            Divider(),
            Container(
              child: Text(
                'ເລືອກວິທີການຈັດສົ່ງ',
              ),
            ),
            MyStatefulWidget(),
            Container(
              child: Text(
                'ແຈ້ງເຕືອນ',
              ),
            ),
            SwitchButton(),
            Divider(),
            Container(
              height: 53.0,
              child: ButtonTheme(
                height: MediaQuery.of(context)
                    .size
                    .width *
                    0.13,
                minWidth: double.infinity,
                child: FlatButton(
                  color: Color.fromARGB(
                      255, 62, 13, 184),
                  onPressed: () {
                    insertData(int.parse(priceController.text),widget.buddhistList[widget.index].id);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                        8.0),
                  ),
                  child: Text(
                    'ປະມູນ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontFamily: 'lao',
                        fontWeight:
                        FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/// Switch Button Sending//////////////////////////////////////////////////////////

enum SingingCharacter { way1, way2 }

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  SharedPreferences pref;

  Widget build(BuildContext context) {
    return Consumer<SelectSending>(
        builder: (context,SelectSending notifiers,child) {
          if (notifiers.sending_byself == 0) {

            print("zoun");

          }else if(notifiers.sending_byself == 1){
            print("nueng");
          }
          return Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      'ຈັດສົ່ງເອງ',
                    ),
                    Spacer(),
                    Radio(
                      value: 0,
                      groupValue: notifiers.sending_byself,
                      onChanged: (value) async {
                        notifiers.Jut_Sg_Eng();

                        print(notifiers.sending_byself);
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      'ຂ້ອຍຈະໃປເອົາໃປສົ່ງ',
                    ),
                    Spacer(),
                    Radio(
                      value: 1,
                      groupValue: notifiers.sending_byself,
                      onChanged: (value) async {
                        notifiers.Khoi_Ja_Ao_Bai_Pai_Sg();

                        print(notifiers.sending_byself);
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
            ],


          );
        });
  }

}

/// Switch Button Notificaiton /////////////////////////////////////////////
class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: <Widget>[
          Text(
            'ແຈ້ງເຕືອນຂ້ອຍຫາກມີຄົນປະມູນສູງກວ່າ ',
          ),
          Spacer(),
          Switch(
            value: value,
            onChanged: (bool newValue) {
              onChanged(newValue);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

class SwitchButton extends StatefulWidget {
  SwitchButton({Key key}) : super(key: key);

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {


  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationIfHasSomeoneAuctionMore>(

      builder: (context,NotificationIfHasSomeoneAuctionMore notifier,child){
        if (notifier.autoNotification == true) {

          print("gg");

        }
        return LabeledSwitch(
          label: 'ແຈ້ງເຕືອນຂ້ອຍຫາກມີຄົນປະມູນສູງກວ່າ',
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          // value: _isSelected,
          value: notifier.autoNotification,
          onChanged: (bool newValue) {

            notifier.toggleAutoNotification();

          },
        );
      },

    );
  }
}

/// Switch Button Auto Acution ////////////////////////////////////////////////
class AutoLabelSwitch extends StatelessWidget {
  const AutoLabelSwitch({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: <Widget>[
          Text(
            'ປະມູນອັດຕະໂນມັດ',
          ),
          Spacer(),
          Switch(
            value: value,
            onChanged: (bool newValue) {
              onChanged(newValue);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

class AutoPaMoon extends StatefulWidget {

  AutoPaMoon({Key key}) : super(key: key);

  @override
  _AutoPaMoonState createState() => _AutoPaMoonState();
}

class _AutoPaMoonState extends State<AutoPaMoon> {


  @override
  Widget build(BuildContext context) {

    return Consumer<AutoAuctionNotifier>(
        builder: (context,AutoAuctionNotifier notifier,child) {

          if (notifier.autoAuction == true) {

            print("_text");

          }
          return AutoLabelSwitch(
            label: 'ປະມູນອັດຕະໂນມັດ',
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            // value: _isSelected,
            value: notifier.autoAuction,

            onChanged: (bool newValue) {
              notifier.toggleAutoAuction();


            },
          );

        }
    );
  }

}








