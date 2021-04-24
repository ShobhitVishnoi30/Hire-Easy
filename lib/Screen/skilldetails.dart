import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/Screen/mainprofile.dart';
import 'package:lotpickproject/constants.dart';
import 'package:lotpickproject/home.dart';

import '../service.dart';
class SkillDetails extends StatefulWidget {
  @override
  _SkillDetailsState createState() => _SkillDetailsState();
}

class _SkillDetailsState extends State<SkillDetails> {
  String skill,level;
  crudMethods fobj=new crudMethods();
  QuerySnapshot skilldata;
  @override
  void initState() {
    fobj.getskilldata().then((results) {
      setState(() {
        skilldata = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(skilldata!=null) {
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
                      "Your Skills",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'BeVietnam',
                        fontSize: 25.0,
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
                                  addskilldetails(context);
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
                  height:double.parse("${skilldata.documents.length}")*130,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: skilldata.documents.length,
                      itemBuilder:(context, i){
                        return new ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 5.0, left: 20.0),
                              child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                            ),

                            title: Container(
                              margin: EdgeInsets.only(top: 0),
                              child: Text("${skilldata.documents[i].data['Skill']}", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                fontFamily: 'BeVietnam'
                              ),),
                            ),

                            subtitle: Column(

                              children: <Widget>[
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
                                                TextSpan(text: 'Experience : ', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BeVietnam')),
                                                TextSpan(text:"${skilldata.documents[i].data['Level']}",style: TextStyle(fontFamily: 'BeVietnam') ),
                                              ],
                                            ),
                                          ),
                                        )
                                    ),

                                  ],
                                ),
                                SizedBox(height: 15,),
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
                                                editskilldetails(context,i);
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
                                                fobj.deleteSkillData(skilldata.documents[i].documentID);
                                                fobj.getskilldata().then((results) {
                                                  setState(() {
                                                    skilldata = results;
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
          child:Scaffold(
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
  Future<dynamic>editskilldetails(BuildContext context,int i) async {


    skill="${skilldata.documents[i].data['Level']}";
    level="${skilldata.documents[i].data['Skill']}";

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Edit your Skills Details",style: TextStyle(fontFamily: 'BeVietnam'),)),
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
                          hintText: '${skill}',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.skill = input,
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
                          hintText: '${level}',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.level = input,
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
                              fobj.editSkillData({
                                'Level': this.level,
                                'Skill': this.skill,


                              },skilldata.documents[i].documentID).then((result) {
                              }).catchError((e) {
                                print(e);
                              });
                              fobj.getskilldata().then((results) {
                                setState(() {
                                  skilldata = results;
                                });
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
  Future<dynamic>addskilldetails(BuildContext context) async {


    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Enter your Skill Details",style: TextStyle(fontFamily: 'BeVietnam'),)),
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

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter Level',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.level = input,
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
                              }).catchError((e) {
                                print(e);
                              });
                              fobj.getskilldata().then((results) {
                                setState(() {
                                  skilldata = results;
                                });
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



