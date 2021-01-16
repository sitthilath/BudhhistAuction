import 'package:buddhistauction/Page/ReleaseBuddhist/first_page.dart';
import 'package:buddhistauction/Page/ReleaseBuddhist/fourth_page.dart';
import 'package:buddhistauction/Page/ReleaseBuddhist/second_page.dart';
import 'package:buddhistauction/Page/ReleaseBuddhist/third_page.dart';
import 'package:buddhistauction/Page/homepage.dart';
import 'package:buddhistauction/Page/landingpage.dart';
import 'package:buddhistauction/Page/loginpage.dart';
import 'package:buddhistauction/Page/otppage.dart';
import 'package:buddhistauction/Page/typelistitempage.dart';
import 'package:buddhistauction/Provider/register_otp.dart';
import 'package:buddhistauction/Provider/store_release_buddhist.dart';
import 'package:buddhistauction/Provider/store_text_register.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Page/detailpage.dart';
import 'Page/registerpage.dart';
import 'Provider/provider_sharepreference_showbottom.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AutoAuctionNotifier(),
          ),
          ChangeNotifierProvider(
            create: (_) => SelectSending(),
          ),
          ChangeNotifierProvider(
            create: (_) => NotificationIfHasSomeoneAuctionMore(),
          ),
          ChangeNotifierProvider(
            create: (_) => RegisterOTP(),
          ),
          ChangeNotifierProvider(
            create: (_) => StoreTextRegister(),
          ),
          ChangeNotifierProvider(
              create: (_) => StoreReleaseBuddhist()),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en',"US"),
            const Locale('th',"TH"),
            const Locale('lo',"LA")

          ],
          debugShowCheckedModeBanner: false,
          home: LandingPage(),
          routes: {
            '/homepage': (context) => HomePage(),
            "/registerpage" : (context) => RegisterPage(),
            "/loginpage" : (context) => LoginPage(),

            '/detailpage': (context) => DetailPage(),
            '/otppage': (context) => OTPPage(),
            '/typelistitempage' : (context)=> TypeListItemPage(),
            "/first_page" : (context) => FirstPage(),
            "/second_page" : (context) => SecondPage(),
            "/third_page" : (context) => ThirdPage(),
            "/fourth_page" : (context) => FourthPage(),
          },
        ));
  }
}
