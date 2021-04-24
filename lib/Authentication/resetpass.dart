
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lotpickproject/Authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPass extends StatefulWidget {
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  TextEditingController emailController = new TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Center(child: new Text("Hire Easy",textAlign: TextAlign.center,),),
        automaticallyImplyLeading: false,
        elevation: 8,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _form,
        child: new Column(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Container(
              child: TextFormField(
                controller: emailController,
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    contentPadding: EdgeInsets.all(10),
                    focusColor: Colors.blueAccent),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF6078ea).withOpacity(.3),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: Material(
                      color: Colors.black,
                      child: InkWell(
                        onTap: () {
                          if (_form.currentState.validate()) {
                            if (emailController.text != '') {
                              resetPassword(emailController.text)
                                  .whenComplete(() {
                                Fluttertoast.showToast(
                                  msg: "An email for resetting password is sent to you",
                                  toastLength: Toast.LENGTH_LONG,
                                );
                                LoginPage();
                              }

                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Please enter email",
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                          }

                        },
                        child: Center(
                          child: Text("Reset",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 18,
                                  )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future resetPassword(String email) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.message);
    }
  }
}


String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Enter Valid Email';
  }
  else {
    return null;
  }
}