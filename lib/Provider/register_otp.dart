import 'package:buddhistauction/Page/authservice.dart';
import 'package:buddhistauction/Page/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterOTP extends ChangeNotifier {

  String verificationId;
  int reSend;
  bool codeSent = false;

  Future<void> verifyPhone(String name,String surname,String password,phoneNo, BuildContext context) async {

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
      this.codeSent = true;
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      this.reSend = forceCodeResend;
      print(verificationId);
      Navigator.of(context).pushNamed('/otppage',
          arguments: OtpArgument(
              verificationIdArg: verificationId, phoneNoArg: phoneNo,name: name,surname: surname,password: password,context: context));
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        forceResendingToken: codeSent ? reSend : null,
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 59),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);
  }
}
