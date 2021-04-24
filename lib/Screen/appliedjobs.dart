import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import 'homepage.dart';
import '../service.dart';
import 'mainprofile.dart';

class AppliedJobs extends StatefulWidget {
  @override
  _AppliedJobsState createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  crudMethods fobj=new crudMethods();
 QuerySnapshot appliedjobdata;
 int selectedIndex=2;
  @override
  void initState() {


        fobj.getappliedjobdata().then((results) {
          setState(() {
            appliedjobdata = results;
          });
        });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(appliedjobdata!=null) {
      if(appliedjobdata.documents.length>0) {
        return new WillPopScope(
          onWillPop: _onWillPop,
          child:Scaffold(
             body: ListView.builder(
               itemCount: appliedjobdata.documents.length,
               itemBuilder: (BuildContext context, int index) =>
                   buildAppliedJobCard(context, index),

             ),

          )
      );
      }
      else{
        return new WillPopScope(
            onWillPop: _onWillPop,
            child:Scaffold(
              body: Center(
                child: Text("You have not applied for any job yet",style: TextStyle(fontFamily: 'BeVietnam'),)
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
          )
      );
    }
  }
  Future<bool> _onWillPop() {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
  Widget buildAppliedJobCard(BuildContext context, int i) {
    return new Container(
      margin: EdgeInsets.only(top: 5,left: 10,right: 10),
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
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                child: Row(children: <Widget>[
                  Text("Company Name : ",
                    style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Flexible(

                    child: Text(appliedjobdata.documents[i].data['Company Name']!=null?appliedjobdata.documents[i].data['Company Name']:'NIL',
                      style: new TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'),),
                  ),


                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                child: Row(children: <Widget>[
                  Text("Designation : ",
                    style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Flexible(
                    child: Text(appliedjobdata.documents[i].data['Designation'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam')),
                  ),

                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                child: Row(children: <Widget>[
                  Text(
                    "Status :    ", style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Text(appliedjobdata.documents[i].data['Status'],
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam')
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                child: Row(children: <Widget>[
                  Text("Interview Mode : ",
                    style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Flexible(
                    child: Text(appliedjobdata.documents[i].data['Interview Mode']!=null?appliedjobdata.documents[i].data['Interview Mode']:'NIL',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam')),
                  ),

                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                child: Row(children: <Widget>[
                  Text("Interview Slot : ",
                    style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Flexible(
                    child: Text(appliedjobdata.documents[i].data['Interview Slot']!=null?appliedjobdata.documents[i].data['Interview Slot']:'NIL',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam')),
                  ),

                ]),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
