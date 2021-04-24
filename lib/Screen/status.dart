import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lotpickproject/constants.dart';
import 'package:lotpickproject/Screen/homepage.dart';
import 'package:lotpickproject/service.dart';

import '../home.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {

  crudMethods fobj=new crudMethods();
  final format = DateFormat("yyyy-MM-dd");
  String status,company,role,work;
  TextEditingController _dateController = new TextEditingController();
  DateTime startdate;
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
    child: Scaffold(

      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            
            children: <Widget>[
              SizedBox(height: 20,),
              Text(
                "Enter Your Status",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'BeVietnam',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30.0),
              _buildstatusTF(),
              SizedBox(
                height: 10.0,
              ),
              _buildcompanyTF(),
              SizedBox(
                height: 10.0,
              ),
              _buildroleTF(),
              SizedBox(
                height: 10.0,
              ),
              _buildworkTF(),
              SizedBox(
                height: 10.0,
              ),
              _buildstartdateTF(),

              SizedBox(
                height: 10.0,
              ),
              _buildsubmitBtn()
            ],
          ),
        ),
      ),

    ),
    );
  }
  Future<bool> _onWillPop() {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(0)));
  }
  Widget _buildstatusTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your Status",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.status=value;
            },
            style: TextStyle(
              color: Colors.black,
                fontFamily: 'BeVietnam'
            ),


            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 4.0),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildcompanyTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Company Name",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.company=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 4.0),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildroleTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your Role",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.role=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 4.0),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildworkTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your Work",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.work=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 4.0),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildstartdateTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Pick Start Date",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          height: 50,
          width: 350,
          decoration: kBoxDecorationStyle,
          child: DateTimeField(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15,bottom: 15),

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
              this.startdate=value;
            },
            controller: _dateController,
          ),
        ),
      ],
    );
  }
  Widget _buildsubmitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
          fobj.addStatusData({
                 "Status":this.status,
            "Role":this.role,
            "Work":this.work,
            "Start Date":_dateController.text,
            "Company Name":this.company,
          }).then((result) {
            dialogTrigger(context);
          }).catchError((e) {
            print(e);
          });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.blue,
        child: Text(
          "Submit",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'BeVietnam',
          ),
        ),
      ),
    );
  }
  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Status Added Succesfully", style: TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam')),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok",style: TextStyle(fontFamily: 'BeVietnam'),),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(0)));
              },
            )
          ],
        );
      },
    );
  }
}
