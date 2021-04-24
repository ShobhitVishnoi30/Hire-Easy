import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import '../home.dart';
import '../service.dart';
import 'jobdetails.dart';

class SearchResult extends StatefulWidget {

  final String company;
  final String designation;
  SearchResult(this.designation,this.company);
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  crudMethods fobj = new crudMethods();
  QuerySnapshot jobdata, appliedjobdata, companydetails, savedjobdata, chatdata;
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
        companydetails = results;
      });
    });
    fobj.getsavedjobs().then((results) {
      setState(() {
        savedjobdata = results;
      });
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if (jobdata != null && appliedjobdata != null && companydetails != null && savedjobdata != null) {
      return new WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              title: Center(child: Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),
            ),
            body: new ListView.builder(
              itemCount: jobdata.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildJobCard(context, index),
            ),
          )
      );
    }else{
      return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            title: Center(child: Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),
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
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(3)));
  }
  Widget buildJobCard(BuildContext context, int i) {



    int l;
    String Name;
    for(l=0;l<companydetails.documents.length;l++)
    {
      if(companydetails.documents[l].documentID==jobdata.documents[i].data['Email'])
      {
        Name=companydetails.documents[l].data['Name'];
        break;
      }
    }
    if(jobdata.documents[i].data['Designation']!=widget.designation && Name!=widget.company){
      return Container(
        width: 0.0,
        height: 0.0,
      );
    }
    for(int q=0;q<savedjobdata.documents.length;q++)
    {
      if(savedjobdata.documents[q].data['DocumentID']==jobdata.documents[i].documentID)
      {
        return new Container(
          height: 0.0,
          width: 0.0,
        );
      }
    }
    for(int k=0;k<appliedjobdata.documents.length;k++)
    {
      if(appliedjobdata.documents[k].data['Company Email']==jobdata.documents[i].data['Email']&&appliedjobdata.documents[k].data['Designation']==jobdata.documents[i].data['Designation']){
        return new Container(
          height: 0.0,
          width: 0.0,
        );
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
                    style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Flexible(
                    child: Text("${Name}",
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
                    child:jobdata.documents[i].data['Designation']!=null?new Text(jobdata.documents[i].data['Designation'], style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam')):new Text("NIL"),
                  ),


                ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 5,bottom: 6),
                child: Row(children: <Widget>[
                  Text(
                    "Location: ", style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Flexible(
                    child: Text(jobdata.documents[i].data['Job Location'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam')
                    ) ,
                  ),


                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                child: Row(children: <Widget>[
                  Text("Role Category : ",
                    style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Flexible(
                    child: Text(jobdata.documents[i].data['Role Category'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam')),
                  ),


                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                child: Row(children: <Widget>[
                  Text(
                    "Office Time:    ", style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Flexible(
                    child: Text(jobdata.documents[i].data['Office Time'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam')
                    ),
                  ),


                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                child: Row(children: <Widget>[
                  Text(
                    "Salary:    ", style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Flexible(
                    child: Text(jobdata.documents[i].data['Salary'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam')
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JobDetails(i,widget.designation,widget.company)));
                          }, child: Text("View Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,fontFamily: 'BeVietnam'),),),
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
                          }, child: Text("Save Job",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,fontFamily: 'BeVietnam'),),)
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
                child: Text('Back',style: TextStyle(fontFamily: 'BeVietnam'),),
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
