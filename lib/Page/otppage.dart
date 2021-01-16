import 'package:buddhistauction/Page/authservice.dart';
import 'package:buddhistauction/Page/registerpage.dart';
import 'package:buddhistauction/Provider/register_otp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OTPPage extends StatefulWidget {
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode pin2FocusNode;

  FocusNode pin3FocusNode;

  FocusNode pin4FocusNode;

  FocusNode pin5FocusNode;

  FocusNode pin6FocusNode;


  String smsCode, otp1, otp2, otp3, otp4, otp5, otp6;



  @override
  void initState() {
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();


    super.initState();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
    super.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    OtpArgument args = ModalRoute.of(context).settings.arguments;



    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  "OTP Verification",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text("We sent your code to +856 20 xxxx xxxx"),

                buildTimer(),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),

                otpForm(args.verificationIdArg),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<RegisterOTP>(context, listen: false)
                        .verifyPhone(args.name,args.surname,args.password,args.phoneNoArg, context);
                  },
                  child: Text("Resend OTP Code"),
                )
                //  OtpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in"),
        TweenAnimationBuilder(
            tween: Tween(begin: 59.0, end: 0.0),
            duration: Duration(seconds: 59),
            builder: (context, value, child) {
              if (value >= 10) {
                return Text(
                  "00:${value.toInt()}",
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Text(
                  "00:0${value.toInt()}",
                  style: TextStyle(color: Colors.red),
                );
              }
            })
      ],
    );
  }

  Form otpForm(String verificationIdArg) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40,
                child: TextFormField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                    otp1 = value;
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    nextField(value, pin3FocusNode);
                    otp2 = value;
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    nextField(value, pin4FocusNode);
                    otp3 = value;
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    nextField(value, pin5FocusNode);
                    otp4 = value;
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    nextField(value, pin6FocusNode);
                    otp5 = value;
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    pin6FocusNode.unfocus();
                    otp6 = value;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          RaisedButton(
            child: Text("Submit"),
            onPressed: () async {
              smsCode = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
             // final idToken =
                  await AuthService().signInWithOTP(smsCode, verificationIdArg,context);
             // debugPrint(idToken, wrapWidth: 1024);
            },
          ),
        ],
      ),
    );
  }


}
