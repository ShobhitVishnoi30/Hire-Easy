import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/JobScreen/ShowAddedJobs.dart';
import 'package:lotpickproject/JobScreen/chatpage.dart';

import '../jobhome.dart';
import '../service.dart';
import 'ViewCandidateProfile.dart';

class ViewCandidate extends StatefulWidget {

  @override
  _ViewCandidateState createState() => _ViewCandidateState();
}

class _ViewCandidateState extends State<ViewCandidate> {
String companyemail,designationtype;
getjobdetails g=new getjobdetails();
  crudMethods fobj=new crudMethods();
  QuerySnapshot appliedcandidatedata;
  @override
  void initState() {
    companyemail=g.getcompanyemail();
    designationtype=g.getdesignationtype();
    fobj.getappliedcandidatedata(designationtype,companyemail).then((results) {
      setState(() {
        appliedcandidatedata = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(appliedcandidatedata!=null){
      return new WillPopScope(
          onWillPop: _onWillPop,
          child:Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              title: Center(child: const Text("Hire Easy")),
            ),
            body: ListView.builder(
              itemCount: appliedcandidatedata.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildappliedcandidateCard(context, index),

            ),
          ));
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
        ),
      );
    }

  }
  Future<bool> _onWillPop() {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JobHome(0)));
  }
  Widget buildappliedcandidateCard(BuildContext context, int i) {

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
      child: GestureDetector(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewCandidateProfile(appliedcandidatedata.documents[i].data['Candidate Email'])));
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
                    Text("Candidate Email : ",
                      style: new TextStyle(fontSize: 15.0),),
                    Flexible(
                      child: Text(appliedcandidatedata.documents[i].data['Candidate Email'],
                        style: new TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'),),
                    ),
                  ]),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 20,),
                      RaisedButton(
                        color: Colors.brown,
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewCandidateProfile(appliedcandidatedata.documents[i].data['Candidate Email'])));
                        },
                        child: Text("Click to see profile",style: TextStyle(color: Colors.white,fontFamily: 'BeVietnam'),),
                      ),
                      SizedBox(width: 20,),
                      RaisedButton(
                        color: Colors.brown,
                        onPressed: (){

                          fobj.addchat({
                           'sender':fobj.user.email,
                            'reciever':appliedcandidatedata.documents[i].data['Candidate Email'],
                              'text':"",
                            'isseen':true
                          }).then((result) {
                          }).catchError((e) {
                            print(e);
                          });
                          fobj.addchatuser({
                            'reciever email':appliedcandidatedata.documents[i].data['Candidate Email'],
                          },appliedcandidatedata.documents[i].data['Candidate Email']).then((result) {
                          }).catchError((e) {
                            print(e);
                          });
                          fobj.addchatuser1({
                            'reciever email':fobj.user.email,
                          },appliedcandidatedata.documents[i].data['Candidate Email']).then((result) {
                          }).catchError((e) {
                            print(e);
                          });
                          return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JobHome(3)));
                        },
                        child: Text("Chat",style: TextStyle(color: Colors.white,fontFamily: 'BeVietnam'),),
                      ),
                    ],
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
