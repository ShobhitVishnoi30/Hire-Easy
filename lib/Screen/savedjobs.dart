import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import '../home.dart';
import '../service.dart';
import 'homepage.dart';
import 'jobdetails.dart';



class SavedJobs extends StatefulWidget {
  @override
  _SavedJobsState createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  crudMethods fobj=new crudMethods();
  QuerySnapshot savedjobdata,jobdata,companydata,appliedjobs;
  @override
  void initState() {
    fobj.getsavedjobs().then((results) {
      setState(() {
        savedjobdata = results;
      });
    });
    fobj.getaddedjobdata().then((results) {
      setState(() {
        jobdata = results;
      });
    });
    fobj.getappliedjobdata().then((results) {
      setState(() {
        appliedjobs = results;
      });
    });

    fobj.getcompanydetails().then((results) {
      setState(() {
        companydata = results;
      });
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(savedjobdata!=null&&jobdata!=null&&companydata!=null&&appliedjobs!=null) {
      if(savedjobdata.documents.length>0) {
        return new WillPopScope(
          onWillPop: _onWillPop,

          child:Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),
            ),
            body: ListView.builder(
              itemCount: jobdata.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildAppliedJobCard(context, index),

            ),

          )
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
                child: Text("You have not saved any job",style: TextStyle(fontFamily: 'BeVietnam'),)
              ),
            )
        );
      }
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
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(0)));
  }
  Widget buildAppliedJobCard(BuildContext context, int i) {






    int j,count=0;
    String companyname;

    for(int k=0;k<companydata.documents.length;k++)
      {
        if(jobdata.documents[i].data['Email']==companydata.documents[k].documentID)
          {
            companyname=companydata.documents[k].data['Name'];
            break;
          }
      }

    for(j=0;j<savedjobdata.documents.length;j++)
    {
      if(savedjobdata.documents[j].data['DocumentID']==jobdata.documents[i].documentID)
      {
        count=1;
        break;
      }
    }
    if(count==1) {
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
                  Flexible(

                    child: Text("${companyname}",
                      style: new TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'),),
                  ),


                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                child: Row(children: <Widget>[
                  Text("Designation : ",
                    style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Flexible(
                    child: Text(jobdata.documents[i].data['Designation'],
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
                  Text(jobdata.documents[i].data['Office Time'],
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam')
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                child: Row(children: <Widget>[
                  Text("Salary : ",
                    style: new TextStyle(fontSize: 15.0,fontFamily: 'BeVietnam'),),
                  Flexible(
                    child: Text(jobdata.documents[i].data['Salary'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'BeVietnam')),
                  ),

                ]),
              ),
              Center(
                child:Row(
                  children: <Widget>[
                    SizedBox(width: 50,),
                    RaisedButton(
                        child: Text("See Details",style: TextStyle(fontFamily: 'BeVietnam'),),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.red)
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => JobDetails(i,null,null)));
                        }

                    ),
                    SizedBox(width: 10,),
                    RaisedButton(
                        child: Text("Remove",style: TextStyle(fontFamily: 'BeVietnam'),),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.red)
                        ),
                        onPressed: () {
                          Firestore.instance.collection('Saved Jobs').document('${fobj.user.email}').collection("savedjob").document("${savedjobdata.documents[j].documentID}").delete().catchError((e){
                            print(e);
                          });
                          fobj.getsavedjobs().then((results) {
                            setState(() {
                              savedjobdata = results;
                            });
                          });
                        }

                    ),
                  ],
                )

              )
            ],
          ),

        ),
      ),
    );
    }else{
      return new Container(
        width: 0.0,
        height: 0.0,
      );
    }
  }
}
