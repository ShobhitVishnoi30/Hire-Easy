
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lotpickproject/JobScreen/profile.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';

import '../constants.dart';
import '../jobhome.dart';
import '../service.dart';

class AddJob extends StatefulWidget {
  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  FirebaseUser user;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
    });
  }
  final format = DateFormat("yyyy-MM-dd");
  QuerySnapshot companydata;
  String companyname='',description='';
  @override
  void initState(){
    getUserData();
    fobj.getcompanydetails().then((results) {
      setState(() {
        companydata = results;
      });
    });

   
  }
  List dataSource=[
    {
      "display": "Male",
      "value": "Male",
    },
    {
      "display": "Female",
      "value": "Female",
    },
    {
      "display": "Others",
      "value": "Others",
    },
  ];
  List dataSource1=[
    {
      "display": "Face to Face",
      "value": "Face to face",
    },
    {
      "display": "Video Conferencing",
      "value": "Video Conferencing",
    },
  ];
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _dateController1 = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  crudMethods fobj=new crudMethods();
 String designation=' ',industry=' ',rolecategory=' ',timing1=' ',timing=' ',education=' ',totalexperience=' ',relevantexperience=' ',gender='',salary=' ',joblocation=' ',weekoffdays=' ',anyhalfday=' ',officetime=' ',jobresponsibility=' ',interviewmode='';
DateTime interviewslot1,interviewslot2;
  @override
  Widget build(BuildContext context) {
    if(companydata!=null) {
      for (int i = 0; i < companydata.documents.length; i++) {
        if (companydata.documents[i].documentID == fobj.user.email) {
          companyname = companydata.documents[i].data['Name'];
          description = companydata.documents[i].data['About'];
          break;
        }
      }
    }
      return new WillPopScope(
        onWillPop: _onWillPop,
    child:Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Center(child: Text("Add Job Vacancy",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:'BeVietnam'),)),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 50.0,
                  child: TextFormField(
                    validator: validatefield,
                    onChanged: (value){
                      this.designation=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                        fontFamily:'BeVietnam'
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter Designation',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 50.0,
                  child: TextFormField(
                    validator: validatefield,
                    onChanged: (value){
                      this.industry=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter Industry ',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 50.0,
                  child: TextFormField(
                    validator: validatefield,
                    onChanged: (value){
                      this.rolecategory=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter Role Category',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 100.0,
                  child: TextFormField(
                    validator: validatefield,
                    keyboardType: TextInputType.multiline,
                    maxLines: 15,
                    onChanged: (value){
                      this.education=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter minimum education qualification required',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 100.0,
                  child: TextFormField(

                    keyboardType: TextInputType.multiline,
                    maxLines: 15,
                    onChanged: (value){
                      this.totalexperience=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter Total Experience',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 100.0,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 15,
                    onChanged: (value){
                      this.relevantexperience=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter relevantexperience',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  decoration: kBoxDecorationStyle,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: 350,

                  child:DropDownFormField(

                    inputDecoration: InputDecoration.collapsed(

                    ),
                    hintText: 'Pick  gender',

                    value: gender,
                    onSaved: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    dataSource: dataSource,
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 50.0,
                  child: TextFormField(
                    validator: validatefield,
                    onChanged: (value){
                      this.salary=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter Salary Range',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 50.0,
                  child: TextField(
                    onChanged: (value){
                      this.joblocation=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter Job Location',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 50.0,
                  child: TextField(
                    onChanged: (value){
                      this.weekoffdays=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter Week off days',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 50.0,
                  child: TextField(
                    onChanged: (value){
                      this.anyhalfday=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter Half days(if any)',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 50.0,
                  child: TextField(
                    onChanged: (value){
                      this.officetime=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter office time',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: 350,
                  decoration: kBoxDecorationStyle,
                  child: DateTimeField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                      hintText: 'Pick Interview Slot 1',

                    ),
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2021));
                    },
                    onChanged: (value){
                      this.interviewslot1=value;
                    },
                    controller: _dateController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 50.0,
                  child: TextField(
                    onChanged: (value){
                      this.timing=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter timing of interview(AM/PM)',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: 350,
                  decoration: kBoxDecorationStyle,
                  child: DateTimeField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                      hintText: 'Pick Interview Slot 2',
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2021));
                    },
                    onChanged: (value){
                      this.interviewslot2=value;
                    },
                    controller: _dateController1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 50.0,
                  child: TextField(
                    onChanged: (value){
                      this.timing1=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter timing of interview(AM/PM)',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  decoration: kBoxDecorationStyle,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: 350,

                  child:DropDownFormField(

                    inputDecoration: InputDecoration.collapsed(

                    ),
                    hintText: 'Pick  Interview Mode',

                    value: interviewmode,
                    onSaved: (value) {
                      setState(() {
                        interviewmode = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        interviewmode = value;
                      });
                    },
                    dataSource: dataSource1,
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 100.0,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 15,
                    onChanged: (value){
                      this.jobresponsibility=value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                    ),


                    decoration: InputDecoration(
                      hintText: 'Enter Job responsibility',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.0,left: 4),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        if( _formKey.currentState.validate()) {
                          if (companyname != '' && description != '') {
                            fobj.addJobData({
                              'Designation': this.designation,
                              'Industry': this.industry,
                              'Role Category': this.rolecategory,
                              'Education': this.education,
                              'Total Experience': this.totalexperience,
                              'Relevant Experience': this.relevantexperience,
                              'Gender': this.gender,
                              'Salary': this.salary,
                              'Job Location': this.joblocation,
                              'Week Off Days': this.weekoffdays,
                              'Any Half Day': this.anyhalfday,
                              'Office Time': this.officetime,
                              'Interview Slot2': _dateController1.text,
                              'Interview Slot1': _dateController.text,
                              'Slot Timing 1': this.timing,
                              'Slot Timing 2': this.timing1,
                              'Interview Mode': this.interviewmode,
                              'Job Responsibility': this.jobresponsibility,
                              'Email': user.email,
                            }).then((result) {
                              _addDialog(context);
                            }).catchError((e) {
                              print(e);
                            });
                          }else{
                            _adddetails(context);
                          }
                        }else{
                          _adddetails1(context);
                        }

                      },
                      child: Center(
                        child: new Text("Submit", style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                      )),
                ),
              ],
            ),

          ],
        ),
      )
    )
    );
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
  _addDialog(BuildContext context)
  {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JobHome(0)));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Job Added Successfully",style: TextStyle(fontFamily:'BeVietnam'),),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  _adddetails(BuildContext context)
  {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK",style: TextStyle(fontFamily:'BeVietnam'),),
      onPressed: () {
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JobHome(2)));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Add company details to add job.",style: TextStyle(fontFamily:'BeVietnam'),),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  _adddetails1(BuildContext context)
  {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK",style: TextStyle(fontFamily:'BeVietnam'),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Fill mandatory fields.",style: TextStyle(fontFamily:'BeVietnam'),),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  String validatefield(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length <= 0) {

      return 'mandatory field';
    }
    else {

      return null;
    }
  }
}
