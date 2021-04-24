import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/Screen/mainprofile.dart';
import 'package:lotpickproject/constants.dart';
import 'package:lotpickproject/service.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';

import '../home.dart';

class PerosnalDetails extends StatefulWidget {
  @override
  _PerosnalDetailsState createState() => _PerosnalDetailsState();
}

class _PerosnalDetailsState extends State<PerosnalDetails> {

  String name='',phone='',phone2='',gender='',house='',street='',city='',state='',country='',pin='',dob1='';
  crudMethods fobj=new crudMethods();
  final TextEditingController _controller = new TextEditingController();

  QuerySnapshot personaldata;
  int i;
  @override
  void initState() {
    fobj.getpersonaldata().then((results) {
      setState(() {
        personaldata = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(personaldata!=null) {

      for(i=0;i<personaldata.documents.length;i++)
      {
        if(fobj.user.email==personaldata.documents[i].documentID)
        {
          name=personaldata.documents[i].data["Name"];
          phone=personaldata.documents[i].data["Phone"];
          phone2=personaldata.documents[i].data["Second Phone"];
          gender=personaldata.documents[i].data["Gender"];
          house=personaldata.documents[i].data["House"] ;
          street=personaldata.documents[i].data["Street"];
          city=personaldata.documents[i].data["City"];
          state=personaldata.documents[i].data["State"] ;
          country=personaldata.documents[i].data["Country"];
          pin=  personaldata.documents[i].data["Pin"];
          dob1=  personaldata.documents[i].data["DOB"];
        }
      }
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
                 "Edit Your Personal Details",
                 style: TextStyle(
                   color: Colors.black,
                   fontFamily: 'BeVietnam',
                   fontSize: 25.0,
                   fontWeight: FontWeight.bold,
                 ),
               ),

               SizedBox(height: 30.0),
               _buildnameTF(),
               SizedBox(height: 30.0),
               _buildphonenumberTF(),
               SizedBox(height: 30.0),
               _buildphonenumber2TF(),
               SizedBox(height: 30.0),
               _buildhouseTF(),
               SizedBox(height: 30.0),
               _buildstreetTF(),
               SizedBox(height: 30.0),
               _buildcityTF(),
               SizedBox(height: 30.0),
               _buildstateTF(),
               SizedBox(height: 30.0),
               _buildcountryTF(),
               SizedBox(height: 30.0),
               _buildpinTF(),
               SizedBox(height: 30.0),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[

                   RaisedButton(
                       color: Colors.green,
                       onPressed: () {
                         fobj.addPersonalData({
                           'Name': this.name,
                           'DOB': this.dob1,
                           'House': this.house,
                           'Street':this.street,
                           'City':this.city,
                           'State':this.state,
                           'Country':this.country,
                           'Pin':this.pin,
                           'Phone':this.phone,
                           'Second Phone':this.phone2,
                           'Gender':this.gender,

                         }).then((result) {
                           _addDialog(context);
                         }).catchError((e) {
                           print(e);
                         });

                       },
                       child: Center(
                         child: new Text("Submit", style: TextStyle(
                             fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam')),
                       )),
                 ],
               ),
             ],
           ),
         ),
     ),
      ),
   );

    }else{
      return new WillPopScope(
          onWillPop: _onWillPop,
      child: Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),
        ),
        body: Center(
          child: LoadingBouncingGrid.circle(
            size: 30,
            backgroundColor: Colors.blue,
          ),
        ),
      ),
      );
    }

  }


  Widget _buildnameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your Name",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.name=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '${name}',
              contentPadding: EdgeInsets.only(top: 4.0,left: 4),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildphonenumberTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your Phone Number",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(

            keyboardType: TextInputType.number,
            onChanged: (value){
              this.phone=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              hintText: '${phone}',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 4.0,left: 4),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildphonenumber2TF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your Second Phone Number",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value){
              this.phone2=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              hintText: '${phone2}',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 4.0,left: 4),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildhouseTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your House Number",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.house=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '${house}',
              contentPadding: EdgeInsets.only(top: 4.0,left: 4),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildstreetTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your Street",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.street=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '${street}',
              contentPadding: EdgeInsets.only(top: 4.0,left: 4),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildcityTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your City",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.city=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '${city}',
              contentPadding: EdgeInsets.only(top: 4.0,left: 4),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildstateTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your State",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.state=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '${state}',
              contentPadding: EdgeInsets.only(top: 4.0,left: 4),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildcountryTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your Country",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.country=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '${country}',
              contentPadding: EdgeInsets.only(top: 4.0,left: 4),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildpinTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your Pin",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.pin=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '${pin}',
              contentPadding: EdgeInsets.only(top: 4.0,left: 4),
            ),
          ),
        ),
      ],
    );
  }
  Future<bool> _onWillPop() {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(2)));
  }
  _addDialog(BuildContext context){

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
                      child: new Text("SuccessFully updated",style: TextStyle(fontFamily: 'BeVietnam'),),
                    ),

                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Back',style: TextStyle(fontFamily: 'BeVietnam'),),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(2)));

                },
              ),
            ],
          );
        }
    );
  }
}
