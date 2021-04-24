import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lotpickproject/Screen/homepage.dart';
import 'package:lotpickproject/constants.dart';
import 'package:lotpickproject/service.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';

import '../home.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final format = DateFormat("yyyy-MM-dd");
  int selectedIndex = 1;
  crudMethods fobj =new crudMethods();
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _dateController = new TextEditingController();
  final TextEditingController _controller1 = new TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var items = ['Male','Female'];
  File _imageFile;
  String url;
  var items1 = ['Beginner','Intermediate','Expert'];
  String name,gender,duration,house,street,dob1,city,state,country,pin,phone,phone2,course,college,marks,session,level,skill,project,projectdetails,worklink,document;
 DateTime dob;
String company,role,workdetails;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {


      return new WillPopScope(
        onWillPop: _onWillPop,

    child: Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: const Text("Gynnasy",style: TextStyle(fontFamily: 'BeVietnam',),)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[

              SizedBox(height: 40,),
              new SizedBox(
                width: 300,
                height: 60,
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)
                  ),
                  color: Colors.green,
                  icon: new Icon(Icons.add),
                  label: new Text("Click to enter your personal details",style: TextStyle(fontFamily: 'BeVietnam',fontSize: 13),),
                  onPressed:() {
                    addpersonaldetails(context);
                  },
                ),
              ),
              Divider(
                height: 40,
              ),
              new SizedBox(
                width: 300,
                height: 60,
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)
                  ),
                  color: Colors.green,
                  icon: new Icon(Icons.add),
                  label: new Text("Click to enter your education details",style: TextStyle(fontFamily: 'BeVietnam',fontSize: 13),),
                  onPressed: (){
                  addeducationdetails(context);
                },
                ),
              ),
              Divider(
                height: 40,
              ),
             new SizedBox(
               width: 300,
               height: 60,
               child: RaisedButton.icon(
                 shape: RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(18.0),
                     side: BorderSide(color: Colors.red)
                 ),
                 color: Colors.green,
                  icon: new Icon(Icons.add),
                 label: new Text("        Click to enter your skills         ",style: TextStyle(fontFamily: 'BeVietnam',fontSize: 13),),
                 onPressed: (){
                    addSkilldetails(context);
                 },
               ),
             ),
              Divider(
                height: 40,
              ),
              new SizedBox(
                width: 300,
                height: 60,
                child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.green,
                  icon: new Icon(Icons.add),
                  label: new Text("Click to enter your project experience",style: TextStyle(fontFamily: 'BeVietnam',fontSize: 13),),
                  onPressed:(){
                    addprojectdetails(context);
                  }
                ),
              ),

              Divider(
                height: 40,
              ),
              new SizedBox(
                width: 300,
                height: 60,
                child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.green,
                    icon: new Icon(Icons.add),
                    label: new Text("Click to enter your experience",style: TextStyle(fontFamily: 'BeVietnam',fontSize: 13),),
                    onPressed:(){
                      _imageFile=null;
                      addexperiencedetails(context);
                    }
                ),
              ),
              Divider(
                height: 40,
              ),
              new SizedBox(
                width: 300,
                height: 60,
                child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.green,
                    icon: new Icon(Icons.add),
                    label: new Text("Click to upload documents",style: TextStyle(fontFamily: 'BeVietnam',fontSize: 13),),
                    onPressed:(){
                      _imageFile=null;
                      adddocumentdetails(context);
                    }
                ),
              ),
              Divider(
                height: 40,
              ),

            ],
          ),
        ),
      ),

    ),
    );


  }
  Future<bool> _onWillPop() {
    return  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(0)));
  }

  Future<dynamic>addpersonaldetails(BuildContext context) async {


    return showDialog(
      context: context,
      barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Enter your perosnal Details",style: TextStyle(fontFamily: 'BeVietnam',),)),
            backgroundColor: Colors.white,
            content:SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 30,bottom: 10,left: 0.0,right: 0.0),
                child: Column(
                  children: <Widget>[
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        validator: validateField,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter your name',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.name = input,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      child: TextFormField(
                        validator: validateField,
                        keyboardType:TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter your phone number',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) => this.phone = input,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      child: TextFormField(
                        validator: validateField,
                        keyboardType:TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter your Seocnd phone number',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) => this.phone2 = input,
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      child: DateTimeField(
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter your date of birth',
                          hintStyle: kHintTextStyle1,
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
                          this.dob=value;
                        },
                        controller: _dateController,
                      ),
                    ),
                    Container(
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      child: new Column(
                        
                        children: [
                          new Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: new Row(
                              children: <Widget>[
                                new Expanded(

                                    child: new TextFormField(
                                      validator: validateField,
                                        controller: _controller,
                            decoration: InputDecoration(
                            border: InputBorder.none,
                              contentPadding: EdgeInsets.all(15.0),
                              hintText: 'Choose gender',
                              hintStyle: kHintTextStyle1,
                            ),
                                    )
                                ),
                                new PopupMenuButton<String>(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onSelected: (String value) {
                                    _controller.text = value;
                                    this.gender=value;
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return items.map<PopupMenuItem<String>>((String value) {
                                      return new PopupMenuItem(child: new Text(value), value: value);
                                    }).toList();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      child: TextFormField(
                        validator: validateField,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter your house number/Flat Number',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) => this.house = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      child: TextFormField(
                        validator: validateField,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter your street/Society',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) => this.street = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter your city',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) => this.city = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter your state',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) => this.state = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter your country',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) => this.country = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter your pin',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) => this.pin = input,
                      ),
                    ),
                    SizedBox(height: 50,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.of(context).pop();
                              fobj.addPersonalData({
                                'Name': this.name,
                                'DOB': _dateController.text,
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
                            child: new Text("Submit", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                        SizedBox(width: 35,),
                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Text("Cancel", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );


        }


    );
  }

  Future<dynamic>addeducationdetails(BuildContext context) async {


    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Enter your Education Details",style: TextStyle(fontFamily: 'BeVietnam'),)),
            backgroundColor: Colors.white,
            content:SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 30,bottom: 10,left: 0.0,right: 0.0),
                child: Column(
                  children: <Widget>[
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter Course',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.course = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter College name',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.college = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter marks(% / CGPA)',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.marks = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter seesion of course(start-end)',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.session = input,
                      ),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.of(context).pop();
                              fobj.addEducationData({
                                'College Name': this.college,
                                'Course Name': this.course,
                                'Marks': this.marks,
                                'Session':this.session,
                                'Email':fobj.user.email,

                              }).then((result) {
                                _addDialog(context);
                              }).catchError((e) {
                                print(e);
                              });

                            },
                            child: new Text("Submit", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                        SizedBox(width: 35,),
                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Text("Cancel", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );


        }


    );
  }
  Future<dynamic>addSkilldetails(BuildContext context) async {


    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Enter your Skills",style: TextStyle(fontFamily: 'BeVietnam'),)),
            backgroundColor: Colors.white,
            content:SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 30,bottom: 10,left: 0.0,right: 0.0),
                child: Column(
                  children: <Widget>[
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter Skill',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.skill = input,
                      ),
                    ),
                    Container(
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      child: new Column(

                        children: [
                          new Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: new Row(
                              children: <Widget>[
                                new Expanded(

                                    child: new TextFormField(
                                      controller: _controller1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(15.0),
                                        hintText: 'Choose Level',
                                        hintStyle: kHintTextStyle1,
                                      ),
                                    )
                                ),
                                new PopupMenuButton<String>(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onSelected: (String value) {
                                    _controller1.text = value;
                                    this.level=value;
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return items1.map<PopupMenuItem<String>>((String value) {
                                      return new PopupMenuItem(child: new Text(value), value: value);
                                    }).toList();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.of(context).pop();
                              fobj.addSkillData({
                                'Skill': this.skill,
                                'Level': this.level,
                              }).then((result) {
                                _addDialog(context);
                              }).catchError((e) {
                                print(e);
                              });

                            },
                            child: new Text("Submit", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                        SizedBox(width: 35,),
                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Text("Cancel", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );


        }


    );
  }
  Future<dynamic>addprojectdetails(BuildContext context) async {


    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Enter your Project Details",style: TextStyle(fontFamily: 'BeVietnam'),)),
            backgroundColor: Colors.white,
            content:SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 30,bottom: 10,left: 0.0,right: 0.0),
                child: Column(
                  children: <Widget>[
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter Project Name',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.project = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter Details Of Project',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.projectdetails = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter link to your work',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.worklink = input,
                      ),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.of(context).pop();
                              fobj.addProjectData({
                                'Project Name': this.project,
                                'Project Details': this.projectdetails,
                                'Link': this.worklink,
                                'Email':fobj.user.email,
                              }).then((result) {
                                _addDialog(context);
                              }).catchError((e) {
                                print(e);
                              });

                            },
                            child: new Text("Submit", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                        SizedBox(width: 35,),
                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Text("Cancel", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );


        }


    );
  }
  Future<dynamic>addexperiencedetails(BuildContext context) async {


    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Enter your Experience",style: TextStyle(fontFamily: 'BeVietnam'),)),
            backgroundColor: Colors.white,
            content:SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 30,bottom: 10,left: 0.0,right: 0.0),
                child: Column(
                  children: <Widget>[
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter Company Name',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.company = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter duration in which you worked',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.duration = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter your role',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.role = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 150,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter Details of your work x',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.workdetails = input,
                      ),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.of(context).pop();
                              fobj.addExperienceData({
                                'Company Name': this.company,
                                'Role': this.role,
                                'Details': this.workdetails,
                                'Duration':this.duration

                              }).then((result) {
                                _addDialog(context);
                              }).catchError((e) {
                                print(e);
                              });

                            },
                            child: new Text("Submit", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                        SizedBox(width: 35,),
                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Text("Cancel", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );


        }


    );
  }
  Future<dynamic>adddocumentdetails(BuildContext context) async {


    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Upload Your Documents",style: TextStyle(fontFamily: 'BeVietnam',),)),
            backgroundColor: Colors.white,
            content:SingleChildScrollView(
              child: Form(
                  key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(top: 30,bottom: 10,left: 0.0,right: 0.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        margin: EdgeInsets.all(20.0),
                        height: 60,
                        child: TextFormField(
                            validator: validatedocument,
                            decoration: InputDecoration(

                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(14.0),
                              hintText: 'Enter Document Name',
                              hintStyle: kHintTextStyle,
                            ),
                            onSaved: (input) {
                              this.document = input;


                            }
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(
                          children: <Widget>[
                            RaisedButton(onPressed: getImage,child: Text("get image",style: TextStyle(fontFamily: 'BeVietnam',),),color: Colors.blue,),
                            SizedBox(width: 10),
                            RaisedButton(onPressed: getFile,child: Text("Get File",style: TextStyle(fontFamily: 'BeVietnam',),),color: Colors.blue,)
                          ],
                        ),

                      ),

                      RaisedButton(

                        elevation: 7.0,
                        child: Text("Upload",style: TextStyle(fontFamily: 'BeVietnam',),),
                        textColor: Colors.white,
                        color: Colors.red,
                        onPressed: () async{
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if(_imageFile!=null) {
                              showLoadingDialog(context, _keyLoader);
                              final StorageReference firebaseStorgaeRef = FirebaseStorage
                                  .instance.ref().child(
                                  fobj.user.email + "/" + "${this.document}");
                              final StorageUploadTask task = firebaseStorgaeRef
                                  .putFile(
                                  _imageFile);
                              StorageTaskSnapshot taskSnapshot = await task
                                  .onComplete;
                              String url = await taskSnapshot.ref
                                  .getDownloadURL();
                              await Firestore.instance.collection("Documents")
                                  .document("${fobj.user.email}").collection(
                                  "document").document()
                                  .setData({
                                'Email': fobj.user.email,
                                'URL': url,
                                'Document': this.document,

                              });

                              Navigator.of(
                                  _keyLoader.currentContext,
                                  rootNavigator: true).pop();
                              showuploadDialog(context);
                            }else{
                              showerror(context);
                            }
                          }


                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 5,right: 7),
                            child: RaisedButton(
                                color: Colors.green,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: new Text("Cancel", style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );


        }


    );

  }
  Future<dynamic>showuploadDialog(BuildContext context) async {
    return showDialog(
      context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Document Uploaded",style: TextStyle(fontFamily: 'BeVietnam'),)),
            content: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left:70),
                    child: Center(
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("ok",style: TextStyle(fontSize: 20,fontFamily: 'BeVietnam'),),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );

        }


    );
  }



  Future getImage() async {
    File image;
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image;
    });
  }
  Future getFile() async {
    File image;
    image = await FilePicker.getFile();
    setState(() {
      _imageFile = image;
    });
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
                        Text("Please Wait Uploading....",style: TextStyle(color: Colors.blueAccent,fontFamily: 'BeVietnam'),)
                      ]),
                    )
                  ]));
        });
  }
  String validate(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length < 2)
      return 'Please Enter document Name';
    else
      return null;
  }
  String validateField(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length==0) {

      return 'Enter enter requires fields';
    }
    else {
      return null;
    }
  }
  Future<dynamic>showerror(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Pick Image/File",style: TextStyle(fontFamily: 'BeVietnam'),)),
            content: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left:70),
                    child: Center(
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("ok",style: TextStyle(fontSize: 20,fontFamily: 'BeVietnam'),),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );

        }


    );
  }
  String validatedocument(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length < 2) {

      return 'Provide document name';
    }
    else {

      return null;
    }
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
                      child: new Text("Successfully submitted",style: TextStyle(fontFamily: 'BeVietnam'),),
                    ),

                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Back',style: TextStyle(fontFamily: 'BeVietnam')),
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
