import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/Screen/applyforjob.dart';
import 'package:lotpickproject/Screen/searchresult.dart';

import '../home.dart';
import 'homepage.dart';
import '../service.dart';

class JobDetails extends StatefulWidget {
  final int k;
  final String designation,company;
  JobDetails(this.k,this.designation,this.company);
  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  crudMethods fobj=new crudMethods();
  QuerySnapshot jobdata,companydetails;
  int i;
  FirebaseUser user;
  Future<void>getUserData()async{
    FirebaseUser userData=await FirebaseAuth.instance.currentUser();
    setState(() {
      user=userData;
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
    fobj.getcompanydetails().then((results) {
      setState(() {
        companydetails = results;
      });
    });
    super.initState();
  }
  int l;
  String name,about;
  @override
  Widget build(BuildContext context) {
    i=widget.k;
    if(jobdata!=null&&companydetails!=null) {

      for(l=0;l<companydetails.documents.length;l++)
      {
        if(companydetails.documents[l].documentID==jobdata.documents[i].data['Email'])
        {
          name=companydetails.documents[l].data['Name'];
          about=companydetails.documents[l].data['About'];
          break;
        }
      }
      return new WillPopScope(
        onWillPop: _onWillPop,
    child: Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily:'BeVietnam'),)),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height:20),
              Container(
                child: Text("Job Details",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily:'BeVietnam'),),
              ),
              SizedBox(height: 20,),
              Divider(thickness: 2,height: 0,),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Text("Company Name : " ,style: new TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold,fontFamily:'BeVietnam'),),
                  Flexible(
                    child: Text("${name}",
                      style: new TextStyle(
                          fontSize: 20.0,fontFamily:'BeVietnam'),),
                  ),
                ]),
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text("About Company : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'BeVietnam')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Flexible(
                    child: Text("${about}",
                      style: new TextStyle(
                          fontSize: 18.0,fontFamily:'BeVietnam'),),
                  ),

                ]),
              ),
              Divider(thickness: 2,height: 0,),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 6.0,left: 20,right: 10),
                child: Row(children: <Widget>[
                  Text("Designation : " ,style: new TextStyle(
                    fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily:'BeVietnam'),),
                  Flexible(
                    child: Text("${jobdata.documents[i].data['Designation']}",
                        style: new TextStyle(
                             fontSize: 20.0,fontFamily:'BeVietnam')

                    ),
                  ),

                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Text("Role Category : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'BeVietnam')),
                  Flexible(
                    child: Text(jobdata.documents[i].data['Role Category'],
                          style: new TextStyle(
                              fontSize: 20.0,fontFamily:'BeVietnam')
                      ),
                  ),



                ]),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20,top: 10),
                  child: Text("Education : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'BeVietnam')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Flexible(
                    child: Text(jobdata.documents[i].data['Education'],
                        style: new TextStyle(
                            fontSize: 20.0,fontFamily:'BeVietnam')
                    ),
                  ),


                ]),
              ),
              Divider(thickness: 2,height: 0,),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20,top: 10),
                  child: Text("Job Responsibility : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'BeVietnam')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Flexible(
                    child: Text(jobdata.documents[i].data['Job Responsibility'],
                        style: new TextStyle(
                           fontSize: 20.0,fontFamily:'BeVietnam')
                    ),
                  ),


                ]),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Text("Total Experience : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'BeVietnam')),
                  Flexible(
                    child: Text(jobdata.documents[i].data['Total Experience'],
                        style: new TextStyle(
                            fontSize: 20.0,fontFamily:'BeVietnam')
                    ),
                  ),


                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Text("Relevant Experience : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'BeVietnam')),
                  Flexible(
                    child: Text(jobdata.documents[i].data['Relevant Experience'],
                        style: new TextStyle(
                            fontSize: 20.0,fontFamily:'BeVietnam')
                    ),
                  ),


                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Text(
                    "Job Location:    ", style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily:'BeVietnam'),),
                  Text(jobdata.documents[i].data['Job Location'],
                      style: new TextStyle(fontSize: 20.0,fontFamily:'BeVietnam')
                  ),


                ]),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Text(
                    "Office Time:    ", style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily:'BeVietnam', ),),
                  Text(jobdata.documents[i].data['Office Time'],
                      style: new TextStyle(
                          fontSize: 20.0,fontFamily:'BeVietnam')
                  ),


                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Text(
                    "Week Off days:    ", style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily:'BeVietnam'),),
                  Text(jobdata.documents[i].data['Week Off Days'],
                      style: new TextStyle(
                           fontSize: 20.0,fontFamily:'BeVietnam')
                  ),
                  Spacer(),

                ]),
              ),
             
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Text(
                    "Half days:    ", style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily:'BeVietnam' ),),
                  Text(jobdata.documents[i].data['Any Half Day'],
                      style: new TextStyle(
                          fontSize: 20.0,fontFamily:'BeVietnam')
                  ),
                  Spacer(),

                ]),
              ),
              Divider(thickness: 2,height: 0,),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 6.0,left: 20),
                child: Row(children: <Widget>[
                  Text(
                    "Interview Mode:    ", style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily:'BeVietnam'),),
                  Text(jobdata.documents[i].data['Interview Mode'],
                      style: new TextStyle(
                           fontSize: 20.0,fontFamily:'BeVietnam')
                  ),
                  Spacer(),

                ]),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20,top: 10),
                  child: Text("Interview Slot1 and timing: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'BeVietnam')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0,left: 30),
                child: Row(children: <Widget>[
                  Flexible(
                    child: Text("Date :       ${ jobdata.documents[i].data['Interview Slot1']}",
                        style: new TextStyle(
                            fontSize: 20.0,fontFamily:'BeVietnam')
                    ),
                  ),


                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0,left: 30),
                child: Row(children: <Widget>[
                  Flexible(
                    child: Text("Timing :   ${ jobdata.documents[i].data['Slot Timing 1']}",
                        style: new TextStyle(
                            fontSize: 20.0,fontFamily:'BeVietnam')
                    ),
                  ),


                ]),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20,top: 10),
                  child: Text("Interview Slot2 and timing: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'BeVietnam')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0,left: 30),
                child: Row(children: <Widget>[
                  Flexible(
                    child: Text("Date :       ${ jobdata.documents[i].data['Interview Slot2']}",
                        style: new TextStyle(
                            fontSize: 20.0,fontFamily:'BeVietnam')
                    ),
                  ),


                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0,left: 30),
                child: Row(children: <Widget>[
                  Flexible(
                    child: Text("Timing :   ${ jobdata.documents[i].data['Slot Timing 2']}",
                        style: new TextStyle(
                            fontSize: 20.0,fontFamily:'BeVietnam')
                    ),
                  ),


                ]),
              ),
              Divider(thickness: 2,height: 0,),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0,left: 130.0),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(28.0),
                          side: BorderSide(color: Colors.red)
                      ),
                      onPressed: () {
                       if(widget.company!=null||widget.designation!=null)
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ApplyForJob(i,name,widget.designation,widget.company)));
                       else
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ApplyForJob(i,name,null,null)));
                      }, child: Text("Apply Now",style: TextStyle(fontFamily:'BeVietnam',fontWeight: FontWeight.bold,fontSize: 15.0),),),
                  ],
                ),
              ),
            ],
          )
        ],
      ),

    )
    );
    }else{
      return new WillPopScope(
          onWillPop: _onWillPop,
          child:Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily:'BeVietnam'),)),
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
    if(widget.company==null&&widget.designation==null) {
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(0)));
    }
    else{
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchResult(widget.designation,widget.company)));
    }
  }

}
