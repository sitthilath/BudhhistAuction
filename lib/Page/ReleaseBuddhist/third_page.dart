import 'package:buddhistauction/Page/ReleaseBuddhist/fourth_page.dart';
import 'package:buddhistauction/Provider/store_release_buddhist.dart';
import 'package:buddhistauction/TransitionPageRoute/slide_left_right.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  int _value ;
  var _key = GlobalKey<FormState>();
  TextEditingController _priceStart = new TextEditingController();
  TextEditingController _priceSmallest = new TextEditingController();
  TextEditingController _bankName = new TextEditingController();
  TextEditingController _accountName = new TextEditingController();
  TextEditingController _accountNumber = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ປ່ອຍເຄື່ອງ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ລາຄາເລີ່ມຕົ້ນ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                SizedBox(
                  height: 10,
                ),
                Consumer<StoreReleaseBuddhist>(
                  builder: (context, srb, child) {
                    if (_priceStart.text != srb.priceStart) {

                      _priceStart.text = srb.priceStart ?? '';
                    }
                    return TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _priceStart,
                      onChanged: (value) {
                        srb.setPriceStart(value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'ກະລຸນາລາຄາ';
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
                Text("ລາຄາບໍ່ໃຫ້ຫຼຸດ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                SizedBox(
                  height: 10,
                ),
                Consumer<StoreReleaseBuddhist>(
                  builder: (context, srb, child) {
                    if (_priceSmallest.text != srb.priceSmallest) {

                      _priceSmallest.text = srb.priceSmallest ?? '';
                    }
                   return TextFormField(
                     keyboardType: TextInputType.number,
                      onChanged: (value) {
                        srb.setPriceSmallest(value);
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
                Text("ຊໍາລະຜ່ານທາງ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {
                        if (_value != srb.indexPayThrough) {

                          _value = srb.indexPayThrough ?? '';
                        }
                       return ChoiceChip(
                          backgroundColor: Color.fromARGB(255, 253, 200, 200),
                          selectedColor: Color.fromARGB(255, 62, 13, 184),
                          labelStyle: _value == 0 ? TextStyle(
                              color: Colors.white) : TextStyle(
                              color: Colors.black),
                          label: Text('ເງິນສົດ'),
                          selected: _value == 0,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? 0 : null;
                              srb.setPayThrough('ເງິນສົດ',0);
                            });
                            print(_value);
                          },

                          //  selectedColor: isSelected ? Colors.black : Colors.white
                        );

                      }),
                    SizedBox(
                      width: 10,
                    ),
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {
                        if(_value != srb.indexPayThrough){
                          _value = srb.indexPayThrough ?? '';
                        }
                      return ChoiceChip(
                          backgroundColor: Color.fromARGB(255, 253, 200, 200),
                          selectedColor: Color.fromARGB(255, 62, 13, 184),
                          labelStyle: _value == 1 ? TextStyle(
                              color: Colors.white) : TextStyle(
                              color: Colors.black),

                          label: Text('ໂອນຜ່ານທະນາຄານ'),
                          selected: _value == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? 1 : null;
                              srb.setPayThrough('ໂອນຜ່ານທະນາຄານ',1);
                            });
                            print(_value);
                          },
                          //  selectedColor: isSelected ? Colors.black : Colors.white
                        );

                      }),
                    SizedBox(
                      width: 10,
                    ),
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {
                        if(_value != srb.indexPayThrough){
                          _value = srb.indexPayThrough ?? '';
                        }
                       return ChoiceChip(
                          //backgroundColor: Color.fromARGB(255, 253, 243, 243),
                          backgroundColor: Color.fromARGB(255, 253, 200, 200),
                          selectedColor: Color.fromARGB(255, 62, 13, 184),
                          labelStyle: _value == 2 ? TextStyle(
                              color: Colors.white) : TextStyle(
                              color: Colors.black),
                          label: Text('Onepay'),
                          selected: _value == 2,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? 2 : null;
                              srb.setPayThrough('Onepay',2);
                            });
                            print(_value);
                          },
                          //  selectedColor: isSelected ? Colors.black : Colors.white
                        );

                      }),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                _value == 1 ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ຊື່ທະນາຄານ",style: TextStyle(color: Colors.brown[400],fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {
                        if(_bankName.text != srb.bankName){
                          _bankName.text = srb.bankName ?? '';
                        }
                       return TextFormField(
                         controller: _bankName,
                          onChanged: (value) {
                            srb.setBankName(value);
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
                    Text("ຊື່ເຈົ້າຂອງບັນຊີ",style: TextStyle(color: Colors.brown[400],fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {
                        if(_accountName.text != srb.accountName){
                          _accountName.text = srb.accountName ?? '';
                        }
                       return TextFormField(
                         controller: _accountName,
                          onChanged: (value) {
                            srb.setAccountName(value);
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
                    Text("ເລກບັນຊີ",style: TextStyle(color: Colors.brown[400],fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<StoreReleaseBuddhist>(
                      builder: (context, srb, child) {
                        if(_accountNumber.text != srb.accountNumber){
                          _accountNumber.text = srb.accountNumber ?? '';
                        }
                       return TextFormField(
                         keyboardType: TextInputType.number,
                         controller: _accountNumber,
                          onChanged: (value) {
                            srb.setAccountNumber(value);
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
                  ],
                ) : Container(),
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
                  backgroundColor: Color.fromARGB(255, 62, 13, 184),

                  child: Text("3",style:TextStyle(color:Colors.white,fontSize: 26,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("ລາຄາ",style:TextStyle(color:Colors.black,fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
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
                  child: Text("4",style:TextStyle(color:Colors.white,fontSize: 26,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("ຈັດສົ່ງ",style:TextStyle(color:Color.fromARGB(255, 253, 200, 200),fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'boonhome')),
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
        child: Text('ຕໍ່ໄປ',style: TextStyle(
            fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        onPressed: (){
          if (_key.currentState.validate()) {
            _key.currentState.save();

            //Navigator.pushNamed(context, "/fourth_page");
            var payThrough = Provider.of<StoreReleaseBuddhist>(context,listen:false).payThrough;
            if(payThrough == null){
              Fluttertoast.showToast(
                  msg: "ກະລຸນາເລືອກການຊໍາລະຜ່ານທາງ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }else{
              Navigator.push(context, SlideRightRoute(page: FourthPage()));
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
