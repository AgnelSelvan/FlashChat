import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import './../utils/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool _obsureText = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (val) =>
                            !val.contains('@') ? 'Invalid email' : null,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          icon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obsureText,
                        validator: (val) =>
                            val.length < 8 ? 'Password too short' : null,
                        decoration: InputDecoration(
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obsureText = !_obsureText;
                              });
                            },
                            child: Icon(
                              _obsureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          labelText: "Password",
                          hintText: "Enter the password, min length 8",
                          icon: Icon(Icons.lock),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: RaisedButton(
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              print("Cannot be empty");
                              return;
                            }
                            bool res = await AuthProvider().signInWithEmail(
                                _emailController.text,
                                _passwordController.text);
                            if (!res) {
                              print("Login Failed");
                            }
                            else{
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                            }
                          }),
                    ),
              SizedBox(
                height: 24.0,
              ),
              // RoundedButton(
              //   colour: Colors.lightBlueAccent,
              //   text: 'LOG IN',
              //   onPressed: () async {
              //     setState(() {
              //       showSpinner = true;
              //     });
              //     final signInUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
              //     if(signInUser != null){
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
              //     }
              //     setState(() {
              //       showSpinner = false;
              //     });
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
