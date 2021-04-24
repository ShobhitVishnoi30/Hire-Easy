import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:lotpickproject/Authentication/login.dart';
import 'package:lotpickproject/Screen/appliedjobs.dart';
import 'package:lotpickproject/Screen/viewprofile.dart';
import 'package:lotpickproject/Screen/mainprofile.dart';
import 'package:lotpickproject/service.dart';
import 'package:lotpickproject/Screen/status.dart';
import '../home.dart';
import 'editprofile.dart';
import 'dart:io';
import 'package:loading/loading.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';

import 'jobdetails.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
int a;
class _HomePageState extends State<HomePage> {
  crudMethods fobj=new crudMethods();
QuerySnapshot jobdata,appliedjobdata,companydetails,savedjobdata,chatdata;
  FirebaseUser currentuser;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      currentuser = userData;
    });
  }
  @override
  void initState() {
    getUserData();
      fobj.getjobdata().then((results) {
        setState(() {
          jobdata = results;
        });
      });
    fobj.getappliedjobdata().then((results) {
      setState(() {
        appliedjobdata = results;
      });
    });

    fobj.getcompanydetails().then((results) {
      setState(() {
        companydetails= results;
      });
    });
    fobj.getsavedjobs().then((results) {
      setState(() {
        savedjobdata= results;
      });
    });

      super.initState();
  }
  int count=0;
  double width,height;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    if(jobdata!=null&&appliedjobdata!=null&&companydetails!=null&&savedjobdata!=null) {



      return new WillPopScope(
     onWillPop: _onWillPop,
       child: Scaffold(
        body: ListView.builder(

                    itemCount: jobdata.documents.length,
                    itemBuilder: (BuildContext context, int index)=>
                        buildJobCard(context, index),
                      ),
       ),
    );
    }
    else{
      return new WillPopScope(
          onWillPop: _onWillPop,
       child: Scaffold(
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
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
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
  Widget buildJobCard(BuildContext context, int i) {



    int l;
    String Name;
    for(int q=0;q<savedjobdata.documents.length;q++)
      {
        if(savedjobdata.documents[q].data['DocumentID']==jobdata.documents[i].documentID)
          {
             return  new Container(
                height: 0.0,
                width: 0.0,
              );

          }
      }
    for(int k=0;k<appliedjobdata.documents.length;k++)
      {
        if(appliedjobdata.documents[k].data['Company Email']==jobdata.documents[i].data['Email']&&appliedjobdata.documents[k].data['Designation']==jobdata.documents[i].data['Designation']){

          return  new Container(
              height: 0.0,
              width: 0.0,

          );
        }
      }
    for(l=0;l<companydetails.documents.length;l++)
      {
        if(companydetails.documents[l].documentID==jobdata.documents[i].data['Email'])
          {
            Name=companydetails.documents[l].data['Name'];
            break;
          }
      }
      return new Container(
          margin: EdgeInsets.only(left: 10,right: 10,top: 5),
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
                        style: new TextStyle(fontSize: 15.0,fontFamily:'BeVietnam'),),
                      Flexible(
                        child: Text("${Name}",
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold,fontFamily:'BeVietnam'),),
                      ),

                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Row(children: <Widget>[
                      Text("Designation : ",
                        style: new TextStyle(fontSize: 15.0,fontFamily:'BeVietnam'),),
                      Flexible(
                        child:jobdata.documents[i].data['Designation']!=null?new Text(jobdata.documents[i].data['Designation'], style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily:'BeVietnam')):new Text("NIL"),
                      ),


                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5,bottom: 6),
                    child: Row(children: <Widget>[
                      Text(
                        "Location: ", style: new TextStyle(fontSize: 15.0,fontFamily:'BeVietnam'),),
                      Flexible(
                        child: Text(jobdata.documents[i].data['Job Location'],
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily:'BeVietnam')
                        ) ,
                      ),



                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Row(children: <Widget>[
                      Text("Role Category : ",
                        style: new TextStyle(fontSize: 15.0,fontFamily:'BeVietnam'),),
                      Flexible(
                        child: Text(jobdata.documents[i].data['Role Category'],
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily:'BeVietnam')),
                      ),


                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Row(children: <Widget>[
                      Text(
                        "Office Time:    ", style: new TextStyle(fontSize: 15.0,fontFamily:'BeVietnam'),),
                      Flexible(
                        child: Text(jobdata.documents[i].data['Office Time'],
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily:'BeVietnam')
                        ),
                      ),


                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Row(children: <Widget>[
                      Text(
                        "Salary:    ", style: new TextStyle(fontSize: 15.0,fontFamily:'BeVietnam'),),
                      Flexible(
                        child: Text(jobdata.documents[i].data['Salary'],
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily:'BeVietnam')
                        ),
                      ),


                    ]),
                  ),

                     Center(
                       child: Container(
                         child: Row(
                           children: <Widget>[
                             SizedBox(width: 50,),
                             RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.red)
                                ),
                                onPressed: () {

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JobDetails(i,null,null)));
                                }, child: Text("View Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,fontFamily:'BeVietnam'),),),
                             SizedBox(width: 10,),
                             RaisedButton(
                               shape: RoundedRectangleBorder(
                                   borderRadius: new BorderRadius.circular(5.0),
                                   side: BorderSide(color: Colors.red)
                               ),
                               onPressed: () {
                                 fobj.addsavedjobs({
                                   "DocumentID":jobdata.documents[i].documentID,
                                 }).then((result) {
                                   _addDialog(context);
                                 }).catchError((e) {
                                   print(e);
                                 });
                               }, child: Text("Save Job",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,fontFamily:'BeVietnam'),),)
                           ],
                         )

                    ),
                     ),




                ],
              ),

            ),
          ),


      );
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
                      child: new Text("SuccessFully saved",style: TextStyle(fontFamily: 'BeVietnam'),),
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

