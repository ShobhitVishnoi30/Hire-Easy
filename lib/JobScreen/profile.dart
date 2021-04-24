import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lotpickproject/Authentication/login.dart';


import '../PrivacyPolicy.dart';

import '../help.dart';
import 'CompanyDetails.dart';

class JobProfile extends StatefulWidget {
  @override
  _JobProfileState createState() => _JobProfileState();
}

class _JobProfileState extends State<JobProfile> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
    child: Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30,),
          _buildTitle("Account Settings"),
          Center(
            child: Column(
              children: <Widget>[
                new ListTile(
                    title: new Text("Company Details",style: TextStyle(fontSize: 20, fontFamily: 'BeVietnam',),),
                    trailing:Icon(Icons.account_box,color: Colors.red),

                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>CompanyDetails()));
                    }),
                SizedBox(height: 20,),
                _buildTitle("Support",),
                Center(
                  child: Column(
                    children: <Widget>[
                      new ListTile(
                          title: new Text("Contact/Support",style: TextStyle(fontSize:20 , fontFamily: 'BeVietnam',),),
                          trailing:Wrap(
                            children: <Widget>[
                              Icon(Icons.phone,color: Colors.red),
                              SizedBox(width: 5,),
                              Icon(Icons.message,color: Colors.red)
                            ],
                          ),

                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Help()));
                          }),


                    ],
                  ),
                ),
                SizedBox(height: 20,),
                _buildTitle("Legal"),
                Center(
                  child: Column(
                    children: <Widget>[
                      new ListTile(
                          title: new Text("Terms Of Services",style: TextStyle(fontSize: 20, fontFamily: 'BeVietnam',),),
                          trailing:Icon(Icons.book,color: Colors.red),

                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Privacy()));
                          }),
                      Divider(thickness: 2,height: 0,),
                      new ListTile(
                          title: new Text("Log Out",style: TextStyle(fontSize: 20, fontFamily: 'BeVietnam',),),
                          trailing:Icon(Icons.exit_to_app,color: Colors.red),

                          onTap: () {
                            _signOut();
                          }),
                      Divider(),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title.toUpperCase(), style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            fontFamily: 'BeVietnam',
          ),),
          Divider(color: Colors.black54,),
        ],
      ),
    );
  }
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?',style: TextStyle( fontFamily: 'BeVietnam',),),
        content: new Text('Do you want to exit an App',style: TextStyle( fontFamily: 'BeVietnam',),),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }
  Future<void> _signOut() async {
    try {
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      await _firebaseAuth.signOut().then((_){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    } catch (e) {
      print(e);
    }
  }
}
