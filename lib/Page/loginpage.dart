// import 'dart:math';
//
// import 'package:buddhistauction/Page/landingpage.dart';
// import 'package:flutter/material.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           ClippedPartsWidget(
//             top: Container(
//               color: Colors.yellow[800],
//             ),
//             bottom: Container(
//               color: Colors.white,
//             ),
//             splitFunction: (Size size, double x) {
//               // normalizing x to make it exactly one wave
//               final normalizedX = x / size.width * 2.8 * pi;
//               final waveHeight = size.height / 50;
//               final y = size.height / 2.4 - sin(normalizedX) * waveHeight;
//
//               return y;
//             },
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.all(10.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//
//               Container(
//                 width: MediaQuery.of(context).size.width / 1.2,
//                 height: 45,
//                 padding:
//                     EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(50)),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(color: Colors.black12, blurRadius: 5)
//                     ]),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     icon: Icon(
//                       Icons.person,
//                       color: Color(0xff6bceff),
//                     ),
//                     hintText: 'Username',
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width / 1.2,
//                 height: 45,
//                 margin: EdgeInsets.only(top: 32),
//                 padding:
//                     EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(50)),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(color: Colors.black12, blurRadius: 5)
//                     ]),
//                 child: TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     icon: Icon(
//                       Icons.vpn_key,
//                       color: Color(0xff6bceff),
//                     ),
//                     hintText: 'Password',
//                   ),
//                 ),
//               ),
//
//                   loginButton(),
//             ]),
//           ),
//
//         ],
//       ),
//     );
//   }
//
//   Widget loginButton() {
//     return ButtonTheme(
//       minWidth: double.infinity,
//       height: 50,
//       child: RaisedButton(
//         color: Color.fromARGB(255, 62, 13, 184),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Text(
//           'ເຂົ້າສູ່ລະບົບ',
//           style: TextStyle(
//               fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         onPressed: () {
//
//
//         },
//       ),
//     );
//   }
// }

import 'package:buddhistauction/Page/registerpage.dart';
import 'package:buddhistauction/LoginBackground/bezierContainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black,size: 40,),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }


  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,

      child: ButtonTheme(
        minWidth: double.infinity,
        height: 50,
        child: RaisedButton(
          color: Color.fromARGB(255, 62, 13, 184),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'ເຂົ້າສູ່ລະບົບ',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/registerpage');

          },
        ),
      ),
    );
  }





  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ທ່ານສະມັກສະມາຊິກແລ້ວບໍ ?',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,fontFamily: 'boonhome'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'ສະມັກສະມາຊິກ',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,fontFamily: 'boonhome'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'ຂ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline1,
            fontSize: 60,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ອ',
              style: TextStyle(color: Colors.black, fontSize: 60),
            ),
            TextSpan(
              text: 'ງດີ',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 60),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Container(
          width: MediaQuery.of(context).size.width,

          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

            Container(
              width: MediaQuery.of(context).size.width / 1,
              height: 60,
              padding:
                  EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 5)
                  ]),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.phone,
                    color: Color(0xff6bceff),
                  ),
                  hintText: 'ເບີໂທ',
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1,
              height: 60,
              margin: EdgeInsets.only(top: 32),
              padding:
                  EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 5)
                  ]),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.vpn_key,
                    color: Color(0xff6bceff),
                  ),
                  hintText: 'ລະຫັດຜ່ານ',
                ),
              ),
            ),
    ],
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(

        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(height: 50),
                      _emailPasswordWidget(),
                      SizedBox(height: 20),
                      _submitButton(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: Text('ລືມລະຫັດຜ່ານ ?',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500,fontFamily: 'boonhome')),
                      ),


                      SizedBox(height: height * .055),
                      _createAccountLabel(),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ));
  }
}
