import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/rounded_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'anonymous_screen.dart';
import './../utils/firebase_auth.dart';


class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_string';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation animationColor;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool _isLoggedIn = false;

  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    animationColor = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animationColor.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value * 70,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
           RoundedButton(
             colour: Colors.lightBlueAccent,
             text: 'LOG IN',
             onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
             },
           ),
//            RoundedButton(
//              colour: Colors.blueAccent,
//              text: 'REGISTER',
//              onPressed: () {
//                Navigator.pushNamed(context, RegistrationScreen.id);
//              },
//            ),
            RoundedButton(
              colour: Colors.green,
              text: 'Chat as Anonymous',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AnonymousScreen()));
              },
            ),
//            RoundedButton(
//              colour: Colors.lightBlueAccent,
//              text: 'LOG IN WITH GOOGLE',
//              onPressed: () {
//                _login();
//              },
//            ),
          ],
        ),
      ),
    );
  }
}
