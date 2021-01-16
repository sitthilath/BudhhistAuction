import 'package:buddhistauction/Provider/store_release_buddhist.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FourthPage extends StatefulWidget {
  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  int _value ;
  var _key = GlobalKey<FormState>();
  TextEditingController _place = new TextEditingController();
  TextEditingController _phoneNumber = new TextEditingController();
  TextEditingController _moreDetail = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ປ່ອຍເຄື່ອງ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'boonhome'))),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ເລືອກຂັ້ນຕອນການຈັດສົ່ງ",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                Row(
                  children: [
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {
                        if (_value != srb.indexDelivery) {
                          // Or check if appState.username != null or what ever your use case is.
                          _value = srb.indexDelivery ?? '';
                        }
                       return ChoiceChip(
                          backgroundColor: Color.fromARGB(255, 253, 200, 200),
                          selectedColor: Color.fromARGB(255, 62, 13, 184),
                          labelStyle: _value == 0 ? TextStyle(
                              color: Colors.white) : TextStyle(
                              color: Colors.black),
                          label: Text('ມາຮັບເອງ'),
                          selected: _value == 0,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? 0 : null;
                              srb.setDelivery('ມາຮັບເອງ',0);
                            });
                            print(_value);
                          },
                          //  selectedColor: isSelected ? Colors.black : Colors.white
                        );

                      }),
                    SizedBox(width: 10,),
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {
                        if (_value != srb.indexDelivery) {
                          // Or check if appState.username != null or what ever your use case is.
                          _value = srb.indexDelivery ?? '';
                        }
                      return ChoiceChip(
                          backgroundColor: Color.fromARGB(255, 253, 200, 200),
                          selectedColor: Color.fromARGB(255, 62, 13, 184),
                          labelStyle: _value == 1 ? TextStyle(
                              color: Colors.white) : TextStyle(
                              color: Colors.black),
                          label: Text('ຈະລົມກັບຜູ້ຊື້'),
                          selected: _value == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? 1 : null;
                              srb.setDelivery('ຈະລົມກັບຜູ້ຊື້',1);
                            });
                          },
                          //  selectedColor: isSelected ? Colors.black : Colors.white
                        );

                      }),
                    SizedBox(width: 10,),
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {
                        if (_value != srb.indexDelivery) {
                          // Or check if appState.username != null or what ever your use case is.
                          _value = srb.indexDelivery ?? '';
                        }
                       return ChoiceChip(
                          backgroundColor: Color.fromARGB(255, 253, 200, 200),
                          selectedColor: Color.fromARGB(255, 62, 13, 184),
                          labelStyle: _value == 2 ? TextStyle(
                              color: Colors.white) : TextStyle(
                              color: Colors.black),
                          label: Text('ຈັດສົ່ງ'),
                          selected: _value == 2,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? 2 : null;
                              srb.setDelivery('ຈັດສົ່ງ', 2);
                            });
                            print(_value);
                          },
                          //  selectedColor: isSelected ? Colors.black : Colors.white
                        );

                      }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _value == 0 ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ສະຖານທີ່",style: TextStyle(color: Colors.brown[400],fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {
                        if (_place.text != srb.placeDelivery) {
                          // Or check if appState.username != null or what ever your use case is.
                          _place.text = srb.placeDelivery ?? '';
                        }
                       return TextFormField(
                         controller: _place,
                          onChanged: (value) {
                            srb.setPlaceDelivery(value);
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

                      }),
                    SizedBox(
                      height: 10,
                    ),
                    Text("ເບີໂທຕິດຕໍ່",style: TextStyle(color: Colors.brown[400],fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {
                        if (_phoneNumber.text != srb.phoneNumber) {
                          // Or check if appState.username != null or what ever your use case is.
                          _phoneNumber.text = srb.phoneNumber ?? '';
                        }
                      return  TextFormField(
                        controller: _phoneNumber,
                          onChanged: (value) {
                            srb.setPhoneNumber(value);
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

                      } ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("ເພີ່ມເຕີມ",style: TextStyle(color: Colors.brown[400],fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {

                        if (_moreDetail.text != srb.moreDetail) {
                          // Or check if appState.username != null or what ever your use case is.
                          _moreDetail.text = srb.moreDetail ?? '';
                        }
                       return TextFormField(
                          onChanged: (value) {
                            srb.setMoreDetail(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'ກະລຸນາປ້ອນຂໍ້ມູນ';
                            }

                            return null;
                          },
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        );

                      }),
                  ],
                ): Container(),
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
          child:  numberPage(),
        ),
      ),
    );
  }

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
                  backgroundColor: Color.fromARGB(255, 253, 200, 200),
                  child: Text("1",style:TextStyle(color:Colors.white,fontSize: 26,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                ),

                SizedBox(
                  height: 5,
                ),
                Text("ລົງຮູບ",style:TextStyle(color:Color.fromARGB(255, 253, 200, 200),fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                alignment: Alignment.topCenter,
                child: Text(
                  ". . . .",
                  style: TextStyle(fontSize: 20,color: Colors.grey),
                )),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 253, 200, 200),

                  child: Text("2",style:TextStyle(color:Colors.white,fontSize: 26,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("ຂໍ້ມູນ",style:TextStyle(color:Color.fromARGB(255, 253, 200, 200),fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                alignment: Alignment.topCenter,
                child: Text(
                  ". . . .",
                  style: TextStyle(fontSize: 20,color: Colors.grey),
                )),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 253, 200, 200),

                  child: Text("3",style:TextStyle(color:Colors.white,fontSize: 26,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("ລາຄາ",style:TextStyle(color:Color.fromARGB(255, 253, 200, 200),fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                alignment: Alignment.topCenter,
                child: Text(
                  ". . . .",
                  style: TextStyle(fontSize: 20,color: Colors.grey),
                )),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 62, 13, 184),

                  child: Text("4",style:TextStyle(color:Colors.white,fontSize: 26,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("ຈັດສົ່ງ",style:TextStyle(color:Colors.black,fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
              ],
            ),
          ],
        ),
      ],
    );
  }


  Widget submitButton(){
    return ButtonTheme(
      minWidth: double.infinity,
      height: 40,
      child: RaisedButton(
        color: Color.fromARGB(255, 62, 13, 184),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text('ສຳເລັດ',style: TextStyle(
            fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        onPressed: (){
          if (_key.currentState.validate()) {
            _key.currentState.save();

           // Navigator.pushNamed(context, "/second_page");
            var delivery = Provider.of<StoreReleaseBuddhist>(context,listen:false).delivery;
            if(delivery == null){
              Fluttertoast.showToast(
                  msg: "ກະລຸນາເລືອກຂັ້ນຕອນການຈັດສົ່ງ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }else{
              //Navigator.push(context, SlideRightRoute(page: TestSecond()));
            }

          } else {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Processing Data')));
          }
        },
      ),
    );
  }
}
