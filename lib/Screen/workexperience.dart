import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/Screen/mainprofile.dart';
import 'package:lotpickproject/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home.dart';
import '../service.dart';
class ExperienceDetails extends StatefulWidget {
  @override
  _ExperienceDetailsState createState() => _ExperienceDetailsState();
}

class _ExperienceDetailsState extends State<ExperienceDetails> {
  String company,duration,role,details;
  crudMethods fobj=new crudMethods();
  QuerySnapshot experiencedata;
  @override
  void initState() {
    fobj.getexperiencedata().then((results) {
      setState(() {
        experiencedata = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(experiencedata!=null) {
      return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),

          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Your Work Experince",
                      style: TextStyle(
                        color: Colors.black,fontFamily: 'BeVietnam',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 30,),
                    SizedBox.fromSize(
                      size: Size(46, 46), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.grey, // button color
                          child: InkWell(
                            splashColor: Colors.red, // splash color
                            onTap: () {
                              addprojectdetails(context);
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add,color: Colors.black,), // icon

                              ],
                            ),
                          ),
                        ),
                      ),
                    )

                  ],

                ),

                SizedBox(height: 30,),
                Container(
                  height:double.parse("${experiencedata.documents.length}")*160,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: experiencedata.documents.length,
                      itemBuilder:(context, i){

                        return new ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 0.0, left: 20.0),
                              child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                            ),

                            title: Container(
                              margin: EdgeInsets.only(top: 10,left: 0.0),
                              child: Text("${experiencedata.documents[i].data['Role']}", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BeVietnam'
                              ),),
                            ),

                            subtitle: Column(

                              children: <Widget>[
                                Row(

                                  children: <Widget>[
                                    Padding(padding: const EdgeInsets.only(top: 20.0,left: 0.0)),
                                    Container(
                                        child: Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              text: '',
                                              style: DefaultTextStyle.of(context).style,
                                              children: <TextSpan>[
                                                TextSpan(text: 'Company Name : ', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BeVietnam')),
                                                TextSpan(text:"${experiencedata.documents[i].data['Company Name']}" ,style: TextStyle(fontFamily: 'BeVietnam')),
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                Row(

                                  children: <Widget>[
                                    Padding(padding: const EdgeInsets.only(top: 20.0,)),
                                    Container(
                                        child: Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              text: '',
                                              style: DefaultTextStyle.of(context).style,
                                              children: <TextSpan>[
                                                TextSpan(text: 'Duration : ', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BeVietnam')),
                                                TextSpan(text:"${experiencedata.documents[i].data['Duration']}",style: TextStyle(fontFamily: 'BeVietnam') ),
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                Row(

                                  children: <Widget>[
                                    Padding(padding: const EdgeInsets.only(top: 20.0,)),
                                    Container(
                                        child: Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              text: '',
                                              style: DefaultTextStyle.of(context).style,
                                              children: <TextSpan>[
                                                TextSpan(text: 'Details : ', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BeVietnam')),
                                                TextSpan(text:"${experiencedata.documents[i].data['Details']}",style: TextStyle(fontFamily: 'BeVietnam') ),
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox.fromSize(
                                        size: Size(46, 46), // button width and height
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.grey, // button color
                                            child: InkWell(
                                              splashColor: Colors.red, // splash color
                                              onTap: () {
                                                editexperiencetdetails(context,i);
                                              }, // button pressed
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(Icons.edit,color: Colors.black,), // icon

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 10,),
                                      SizedBox.fromSize(
                                        size: Size(46, 46), // button width and height
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.grey, // button color
                                            child: InkWell(
                                              splashColor: Colors.red, // splash color
                                              onTap: () {
                                                fobj.deleteExperienceData(experiencedata.documents[i].documentID);
                                                fobj.getexperiencedata().then((results) {
                                                  setState(() {
                                                    experiencedata = results;
                                                  });
                                                });
                                              }, // button pressed
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(Icons.delete,color: Colors.black,), // icon

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                )

                              ],
                            )
                        );
                      }
                  ),
                ),


              ],
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
      )
      );
    }
  }
  Future<bool> _onWillPop() {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(2)));
  }
  Future<dynamic>editexperiencetdetails(BuildContext context,int i) async {


    company="${experiencedata.documents[i].data['Company Name']}";
    details="${experiencedata.documents[i].data['Details']}";
    duration="${experiencedata.documents[i].data['Duration']}";
    role="${experiencedata.documents[i].data['Role']}";
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Edit your Work Details",style: TextStyle(fontFamily: 'BeVietnam'),)),
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
                          hintText: '${company}',
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
                          hintText: '${duration}',
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
                          hintText: '${role}',
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
                          hintText: '${details}',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.details = input,
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
                              fobj.editExperienceData({
                                'Company Name': this.company,
                                'Role': this.role,
                                'Details': this.details,
                                'Duration':this.duration

                              },experiencedata.documents[i].documentID).then((result) {
                                fobj.getexperiencedata().then((results) {
                                  setState(() {
                                    experiencedata = results;
                                  });
                                });
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
            title: Center(child: Text("Enter your project details",style: TextStyle(fontFamily: 'BeVietnam'),)),
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
                          hintText: 'Enter Details of your work ',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.details = input,
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
                                'Details': this.details,
                                'Duration':this.duration

                              }).then((result) {
                                fobj.getexperiencedata().then((results) {
                                  setState(() {
                                    experiencedata = results;
                                  });
                                });
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


}



