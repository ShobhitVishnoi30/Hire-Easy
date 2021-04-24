
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lotpickproject/Authentication/resetpass.dart';
import 'package:lotpickproject/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:lotpickproject/service.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';
import '../home.dart';
import '../jobhome.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginPage extends StatefulWidget {
  FirebaseUser user;
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String _email, _password;
  String role=null;
  int _radioValue=-1;
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          role = 'Job Seeker';
          break;
        case 1:
          role= 'Job Provider';
          break;
      }
    });
  }
  crudMethods fobj=new crudMethods();
  QuerySnapshot personaldata;
  @override
  void initState() {
    _checkInternetConnectivity();
    Future.delayed(Duration(seconds: 5),(){
      fobj.getpersonaldata().then((results) {
        setState(() {
          personaldata = results;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (personaldata != null) {
      return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 40.0,
            ),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 80,),
                    Padding(
                      padding: const EdgeInsets.only(right: 40, bottom: 30),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'BeVietnam',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      height: 60,
                      child: TextFormField(

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.teal,
                            size: 30,
                          ),
                          hintText: 'Enter your Email',
                          hintStyle: kHintTextStyle,
                        ),
                        onSaved: (input) => _email = input,
                      ),
                    ),
                    Container(

                      decoration: kBoxDecorationStyle,
                      height: 60,
                      child: TextFormField(


                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20.0),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.teal,
                            size: 30,
                          ),
                          hintText: 'Enter your Password',
                          hintStyle: kHintTextStyle,
                        ),
                        onSaved: (input) => _password = input,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(


                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  new Radio(
                                    activeColor: Colors.black,
                                    value: 0,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  new Text(
                                    'Student',
                                    style: new TextStyle(fontSize: 16.0,
                                        fontFamily: 'BeVietnam'),
                                  ),
                                  new Radio(
                                    activeColor: Colors.black,
                                    value: 1,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  new Text(
                                    'Faculty',
                                    style: new TextStyle(fontSize: 16.0,
                                        fontFamily: 'BeVietnam'),
                                  ),
                                ],
                              ),

                            ]
                        )
                    ),
                    Container(
                      child: FlatButton(
                        child: Text("Forgot Password ? ", style: TextStyle(
                            color: Colors.black, fontFamily: 'BeVietnam'),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => ResetPass()));
                        },
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: RaisedButton(
                        color: Colors.black,
                        elevation: 10,
                        onPressed: () {
                          _handleSubmit(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text('Log In', style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'BeVietnam',
                              fontWeight: FontWeight.bold,
                              color: Colors.white),)),
                        ),

                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("New User here?", style: TextStyle(
                            fontSize: 15, fontFamily: 'BeVietnam'),),
                        FlatButton(child: Text("Sign Up!",
                          style: TextStyle(fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'BeVietnam'),),
                          onPressed: () {
                            _checkInternetConnectivity();
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                          },)
                      ],
                    )
                  ],
                )
            ),
          ),
        ),
      );
    }else{
      return new WillPopScope(
          onWillPop: _onWillPop,
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: height/3)),
              SpinKitWave(
                color: Colors.blue,
                type: SpinKitWaveType.center,

              ),
              ColorizeAnimatedTextKit(
                text: ['Hire Easy'],

                  colors: [
                    Colors.purple,
                    Colors.blue,
                    Colors.yellow,
                    Colors.red,
                  ],

                  textAlign: TextAlign.center,
                  //alignment: AlignmentDirectional.topStart,
                  textStyle: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    fontFamily:'Holtwood'
                ),

              ),

            ],

          )

        ),

      );
    }
  }
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?',style: TextStyle(fontFamily:'BeVietnam'),),
        content: new Text('Do you want to exit an App',style: TextStyle(fontFamily:'BeVietnam'),),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',style: TextStyle(fontFamily:'BeVietnam'),),
          ),
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes',style: TextStyle(fontFamily:'BeVietnam'),),
          ),
        ],
      ),
    ) ??
        false;
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showDialog(context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("No Internet",style: TextStyle(fontFamily:'BeVietnam'),),
              content: Text("You're not connected to Internet!",style: TextStyle(fontFamily:'BeVietnam'),),
              actions: <Widget>[
                FlatButton(child: Text("Ok"), onPressed: () {
                  exit(0);
                },),
              ],
            );
          }
      );
    }
  }
  _addDialog(BuildContext context){
    Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 25, right: 15,top: 10),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: new Text("Invalid Email or Password.",style: TextStyle(fontFamily:'BeVietnam',fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child: new Text("Please provide correct credentials.",style: TextStyle(fontFamily:'BeVietnam'),),
                    )

                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Back'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();

                },
              ),
            ],
          );
        }
    );
  }


  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
  Future<void> _handleSubmit(BuildContext context) async {
    try {

      //invoking login

      if(_formKey.currentState.validate()){
        _formKey.currentState.save();

         if(_email.length>0 && _password.length>0 && role!=null) {
           showLoadingDialog(context, _keyLoader);
           try {
             AuthResult result = await FirebaseAuth.instance
                 .signInWithEmailAndPassword(
                 email: _email, password: _password);
             user = result.user;

               if (role == 'Job Seeker') {
                 _saveDeviceToken(user.email);
                 Navigator.push(
                     context, MaterialPageRoute(builder: (context) => Home(0)));
               }
               else {
                 _saveDeviceToken(user.email);
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => JobHome(0)));
               }


           } catch (e) {
             _addDialog(context);

             return (e.message);
           }
         }else{
           Fluttertoast.showToast(
             msg: "Please fill all the fields",
             toastLength: Toast.LENGTH_LONG,
           );
         }


      }
      //close the dialoge

    } catch (error) {
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      print(error);
    }
  }
  _saveDeviceToken(String useremail) async {
    // Get the current user
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('User Token')
          .document(useremail);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': DateTime.now().toIso8601String().toString(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }




}
class getDetails{

   getEmail(){
     return user;
   }

}
