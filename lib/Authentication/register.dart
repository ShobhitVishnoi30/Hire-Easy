import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lotpickproject/Authentication/login.dart';
import 'package:lotpickproject/Screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lotpickproject/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();

}
FirebaseUser user;
class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 40.0,
        ),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 80,),
                Padding(
                  padding: const EdgeInsets.only(right: 40,bottom: 30),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
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
                    validator: validateEmail,
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
                    validator: validatePassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(18.0),
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

                SizedBox(height: 30,),
                Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    elevation: 10,
                    onPressed: signUp,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text('Sign Up',style: TextStyle(fontFamily:'BeVietnam',fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
                    ),
                    color: Colors.black,
                  ),
                ),
                SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already Registered?",style: TextStyle(fontSize: 15,fontFamily:'BeVietnam'),),
                    FlatButton( child: Text("Sign in!",style: TextStyle(fontSize: 20,color: Colors.black,fontFamily:'BeVietnam'),),
                      onPressed: (){
                        Navigator.pop(context);
                      },)
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
  String validatePassword(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length < 6)
      return 'Password must be of atleast 6 digit';
    else
      return null;
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




  void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      showLoadingDialog(context, _keyLoader);
      try{
        AuthResult result= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
         if(result!=null){
             Fluttertoast.showToast(
               msg: "Sign up successful.Sign in now ",
               toastLength: Toast.LENGTH_LONG,
             );

         }
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));

      }catch(e){
        print (e.message);
        _addDialog(context,e.message);
      }
    }
  }
  _addDialog(BuildContext context,String message){
    Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 25, right: 25,top: 10),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Container(
                      child: new Text("${message}"),
                    ),

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
}




