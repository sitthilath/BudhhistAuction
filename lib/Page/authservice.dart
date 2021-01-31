import 'dart:convert';

import 'package:buddhistauction/Page/registerpage.dart';
import 'package:buddhistauction/Provider/store_token.dart';
import 'package:buddhistauction/const_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';



class AuthService extends ChangeNotifier{

  ///PushTokenFirebasebToLaravel
  void registerUser(String name, String surname, String phoneNumber,
      String firebaseToken, String password,BuildContext context) {
    String url = "$API_URL/register";
    http
        .post(url,
            headers: {
              'Accept': 'application/json; charset=UTF-8',
            },
            body:{
              'name': name,
              'surname': surname,
              'phone_number': phoneNumber,
              'firebase_token': firebaseToken,
              'password': password,
            })
        .then((response) {
      print('Response status : ${response.statusCode}');
      print('Response status : ${response.body}');

      var result = json.decode(response.body);

      var tk = "Token:"+result['access_token'];
      debugPrint(tk, wrapWidth: 1024);
     print("Token:"+result['access_token']);

      var token = result['access_token'];
      Provider.of<StoreToken>(context,listen:false).setTokens(token);

      if(response.statusCode == 200){
        Navigator.pushNamed(context, "/homepage");

      }else{
        print("error E Y WA");
      }

    }).catchError((e) {
      print("Error: $e");
    });
  }



  signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<UserCredential> signIn(AuthCredential authCredential) {
    return FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  Future<String> signInWithOTP(smsCode, verId, BuildContext context) async {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    try {
      OtpArgument args = ModalRoute.of(context).settings.arguments;

      final UserCredential credential = await signIn(authCredential);
      final idToken = await credential.user.getIdToken();
      registerUser(
          args.name, args.surname, args.phoneNoArg, idToken, args.password,args.context);

      return Future.value(idToken);

    } catch (e) {
      print("SignIn Error: $e");
    }
    return Future.value('');
  }


}

///eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiZGRjYTM4OTQ0ZTZhMDBmZDI5ODdjMzc1ODY3Y2ZjYWEyMTRiY2NjYzJkM2UxNmNlNWQ4NjhmZDJiNjhlOWU3ZDU4NzkyNjViYjlmYmRmOGEiLCJpYXQiOjE2MDkwNjA0MDgsIm5iZiI6MTYwOTA2MDQwOCwiZXhwIjoxNjQwNTk2NDA3LCJzdWIiOiIyMSIsInNjb3BlcyI6W119.XnJmnLlo0_EglVKcbQYxHCR1aBRxdITaSkJQWjAmvPDpeevMYjzWdHHvnrXEdM7CIyd0NBjWK7OUJnvp9-5N9Frs2S6MIdkl7cw3bAmuJty-xKmZ6Efkmfkbrs4mNEYAhOaihD6mwgu-7THQ38ufLbI2ylM_iar0BLGFjjzE1PiULOztQfuwrWOxCTwSytvGp8D6kUReTJ4v_0sjnyq3rtPf9lugv2dS8UJVmw9S2xTqWqeWRDlfNlMIRjtIA7Xj90WVVoBSsRtGdtA_dvoK9qVI7YVCgK26tu6nCVKvkliz-efVYXHFRtFANWsICZvKwk1moaiLpIN94xFvFLYUcw29zrIqclXtUuph1kSTzL2Oj_GT1KXlm9G5RTgSS7MgZkPmyU9KzsV81vNrvMo2QM_p790pbCz1Ua6VctYQvvI7BqD3euu5Y-bd7v668LKA4zJAxYCwhHWIhrBeEBXx2GetnK6HZoM1JOftp0Zy7Dr6nrf42p9ZVdvWWh2UQNQF47DONR8_Yw1lee4K9uEkqK3hRceDzNR1PgPbNXohrFbtah0qqiAOhWNnaCWuHU9JRG-5Fds18whaME7s5saX5Om0faOLOTH3tETRaUoYRSxF7y_y7iPNeFrGgCGlzDdjuSgKnzJaIln-yDwCQH11IiqVm-_OZB6zc9ZJ3dBeXW0