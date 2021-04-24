import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/JobScreen/profile.dart';

import '../jobhome.dart';
import '../service.dart';
import 'ViewAppliedCandidate.dart';

class AddedJobs extends StatefulWidget {
  @override
  _AddedJobsState createState() => _AddedJobsState();
}
String companyemail,designation;
class _AddedJobsState extends State<AddedJobs> {
  FirebaseUser user;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
    });
  }
  crudMethods fobj=new crudMethods();
  QuerySnapshot addedjobdata;
  @override
  void initState() {
      getUserData();
    fobj.getaddedjobdata().then((results) {
      setState(() {
        addedjobdata = results;
      });
    });
    super.initState();
  }
  int count=0;

  @override
  Widget build(BuildContext context) {

    if(addedjobdata!=null) {
      for(int i=0;i<addedjobdata.documents.length;i++)
        {
          if(user.email==addedjobdata.documents[i].data['Email']) {
            count++;

            break;
          }
        }
      if (count> 0) {
        return new WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              body: ListView.builder(
                itemCount: addedjobdata.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildAddedJobCard(context, index),
              ),
            ));
      } else{
        return new WillPopScope(
            onWillPop: _onWillPop,
            child:Scaffold(
              body: Center(
                  child: Text("You have not added any job yet",style: TextStyle( fontFamily: 'BeVietnam',),)
              ),
            )
        );

      }
    }else{
      return new WillPopScope(
        onWillPop: _onWillPop,
        child:Scaffold(
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
  Widget buildAddedJobCard(BuildContext context, int i) {
    if(user.email!=addedjobdata.documents[i].data['Email']) {
      return new Container(
        width: 0.0,
        height: 0.0,
      );
    }
    return new Container(
      margin: EdgeInsets.only(left: 10,right: 10,top:5),
      width: double.infinity,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              10.0, // Move to right 10  horizontally
              10.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: GestureDetector(
        onTap: (){
          companyemail=addedjobdata.documents[i].data['Email'];
          designation=addedjobdata.documents[i].data['Designation'];
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewCandidate()));
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Designation:    ", style: new TextStyle(fontSize: 15.0),),
                    Flexible(
                      child: addedjobdata.documents[i].data['Designation']!=null?new Text(addedjobdata.documents[i].data['Designation'], style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)):new Text("NIL"),

                      ),
                      ]
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Industry :    ", style: new TextStyle(fontSize: 15.0),),
                    Text(addedjobdata.documents[i].data['Industry'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      " Role category   :    ", style: new TextStyle(fontSize: 15.0),),
                    Flexible(
                      child: Text(addedjobdata.documents[i].data['Role Category'],
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Education   :    ", style: new TextStyle(fontSize: 15.0),),
                    Flexible(
                      child: Text(addedjobdata.documents[i].data['Education'],
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                      ),
                    ),

                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Total Experience :    ", style: new TextStyle(fontSize: 15.0),),
                    Flexible(
                      child: Text(addedjobdata.documents[i].data['Total Experience'],
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Relevant Experience :    ", style: new TextStyle(fontSize: 15.0),),
                    Flexible(
                      child: Text(addedjobdata.documents[i].data['Relevant Experience'],
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                      ),
                    ),

                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Gender :    ", style: new TextStyle(fontSize: 15.0),),
                    Text(addedjobdata.documents[i].data['Gender'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                    ),

                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Salary range :    ", style: new TextStyle(fontSize: 15.0),),
                    Text(addedjobdata.documents[i].data['Salary'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                    ),

                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Job location :    ", style: new TextStyle(fontSize: 15.0),),
                    Text(addedjobdata.documents[i].data['Job Location'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Week off day :    ", style: new TextStyle(fontSize: 15.0),),
                    Text(addedjobdata.documents[i].data['Week Off Days'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Any half day :    ", style: new TextStyle(fontSize: 15.0),),
                    Text(addedjobdata.documents[i].data['Any Half Day'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Office time :    ", style: new TextStyle(fontSize: 15.0),),
                    Flexible(
                      child: Text(addedjobdata.documents[i].data['Office Time'],
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Interview Slot1 ( Date) :    ", style: new TextStyle(fontSize: 15.0),),
                    Flexible(
                      child: Text("${addedjobdata.documents[i].data['Interview Slot1']} ,  ${addedjobdata.documents[i].data['Slot Timing 1']}",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Interview Slot2 ( Date & Time) :    ", style: new TextStyle(fontSize: 15.0),),
                    Flexible(
                      child: Text("${addedjobdata.documents[i].data['Interview Slot2']} , ${addedjobdata.documents[i].data['Slot Timing 2']}",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Interview Mode :    ", style: new TextStyle(fontSize: 15.0),),
                    Text("${addedjobdata.documents[i].data['Interview Mode']}",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Job responsibility :    ", style: new TextStyle(fontSize: 15.0),),
                    Flexible(
                      child: Text("${addedjobdata.documents[i].data['Job Responsibility']}",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam',)
                      ),
                    ),
                  ]),
                ),
                Center(
                  child: FlatButton(
                    child: Text("Tap to see applied candidates",style: TextStyle(color: Colors.red,fontFamily: 'BeVietnam',),),
                  ),
                )
              ],
            ),
          ),
          ),
      ),
    );
  }

}
class getjobdetails{
  getcompanyemail(){
    return companyemail;
}
getdesignationtype(){
    return designation;
}
}
