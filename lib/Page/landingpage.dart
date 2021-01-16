import 'dart:math';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ ClippedPartsWidget(

          top: Container(

            color: Colors.yellow[800],
          ),
          bottom: Container(
            color: Colors.white,
          ),
          splitFunction: (Size size, double x) {
            // normalizing x to make it exactly one wave
            final normalizedX = x / size.width * 2.8 * pi;
            final waveHeight = size.height / 50;
            final y = size.height / 2.4 - sin(normalizedX) * waveHeight;

            return y;
          },
        ),

      Positioned(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(


                width: MediaQuery.of(context).size.width/1.8,
                child: Image.asset(
                  'asset/image/icon_landing_page.png'
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/20,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/homepage');

                },
                child: Text(

                  'ມາເລີ່ມກັນເລີຍ',
                  style: TextStyle(
                      fontSize: 38, color: Color.fromARGB(255, 62, 13, 184), fontWeight: FontWeight.bold),

                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/30,
              ),
              Text(
                'ປະມູນ ແລະ ເຊົ່າພຣະ ຂອງມີຄ່າ',
                style: TextStyle(
                    fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                'ໃນແອບພິເຄຊັນດຽວ',
                style: TextStyle(
                    fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/15,
              ),
              registerButton(),
              SizedBox(
                height: MediaQuery.of(context).size.height/30,
              ),
              loginButton(),
              SizedBox(
                height: MediaQuery.of(context).size.height/30,
              ),
            ],
          ),
        ),
      ),
      ]),
    );
  }
  Widget registerButton() {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 50,
      child: RaisedButton(
        color: Color.fromARGB(255, 62, 13, 184),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          'ລົງທະບຽນ',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/registerpage');

        },
      ),
    );
  }
  Widget loginButton() {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 40,
      child: FlatButton(

        child: Text(
          'ເຂົ້າສູ່ລະບົບ',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
            Navigator.pushNamed(context, '/loginpage');

        },
      ),
    );
  }

}

class ClippedPartsWidget extends StatelessWidget {
  final Widget top;
  final Widget bottom;
  final double Function(Size, double) splitFunction;

  ClippedPartsWidget({
    @required this.top,
    @required this.bottom,
    @required this.splitFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // I'm putting unmodified top widget to back. I wont cut it.
        // Instead I'll overlay it with clipped bottom widget.
        top,
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: FunctionClipper(splitFunction: splitFunction),
            child: bottom,
          ),
        ),
      ],
    );
  }
}

class FunctionClipper extends CustomClipper<Path> {
  final double Function(Size, double) splitFunction;

  FunctionClipper({@required this.splitFunction}) : super();

  Path getClip(Size size) {
    final path = Path();

    // move to split line starting point
    path.moveTo(0, splitFunction(size, 0));

    // draw split line
    for (double x = 1; x <= size.width; x++) {
      path.lineTo(x, splitFunction(size, x));
    }

    // close bottom part of screen
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // I'm returning fixed 'true' value here for simplicity, it's not the part of actual question
    // basically that means that clipping will be redrawn on any changes
    return true;
  }
}