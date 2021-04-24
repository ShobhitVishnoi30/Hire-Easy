import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/JobScreen/ViewAppliedCandidate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service.dart';
import 'ShowAddedJobs.dart';

class ViewCandidateProfile extends StatefulWidget {

  final String email;
  ViewCandidateProfile(this.email);
  @override
  _ViewCandidateProfileState createState() => _ViewCandidateProfileState();
}

class _ViewCandidateProfileState extends State<ViewCandidateProfile> {
  String companyemail,designationtype;
  getjobdetails g=new getjobdetails();
  crudMethods fobj=new crudMethods();
  Uint8List imageFile;
  StorageReference storageReference = FirebaseStorage.instance.ref().child("user_profile");
  fetchImageFromFirebase(a) {
    int maxSize = 5*1024*1024;
    storageReference.child("image_$a.jpg").getData(maxSize).then((value){
      setState(() {
        imageFile = value;
      });
    });
  }
  QuerySnapshot candidatepersonaldata,appliedcandidatedata,candidateskilldata,candidateprojectdata,candidateexperiencedata,candidateeducationdata,candidatestatusdata,profiledata;
  @override
  void initState() {
    companyemail=g.getcompanyemail();
    designationtype=g.getdesignationtype();
    fetchImageFromFirebase(widget.email);
    fobj.getcandidatepersonaldata().then((results) {
      setState(() {
        candidatepersonaldata = results;
      });
    });
    fobj.getcandidateskilldata(widget.email).then((results) {
      setState(() {
        candidateskilldata = results;
      });
    });
    fobj.getcandidateprojectdata(widget.email).then((results) {
      setState(() {
        candidateprojectdata = results;
      });
    });
    fobj.getcandidateeducationdata(widget.email).then((results) {
      setState(() {
        candidateeducationdata = results;
      });
    });
    fobj.getcandidateexperiencedata(widget.email).then((results) {
      setState(() {
        candidateexperiencedata = results;
      });
    });
    fobj.getcandidatestatusdata().then((results) {
      setState(() {
        candidatestatusdata = results;
      });
    });
    fobj.getappliedcandidatedata(designationtype,companyemail).then((results) {
      setState(() {
        appliedcandidatedata = results;
      });
    });
    super.initState();
  }
  int i,j,k,i1,k1,c1;
  String interviewmode,interviewslot,noticeperiod,reason;
  String phone='',phone2='',gender='',house='',street='',city='',state='',country='',pin='',name='',dob='';
  String companyname='',role='',startdate='',status='',work='';
  String url="https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";
  @override
  Widget build(BuildContext context) {
    if(candidatepersonaldata!=null&&appliedcandidatedata!=null&&candidatestatusdata!=null&&candidateskilldata!=null&&candidateprojectdata!=null&&candidateeducationdata!=null&&candidateexperiencedata!=null){
      for( i=0;i<candidatepersonaldata.documents.length;i++)
      {
        if(widget.email==candidatepersonaldata.documents[i].documentID)
        {
          name=candidatepersonaldata.documents[i].data["Name"];
          dob=candidatepersonaldata.documents[i].data["DOB"];
          phone=candidatepersonaldata.documents[i].data["Phone"];
          phone2=candidatepersonaldata.documents[i].data["Second Phone"];
          gender=candidatepersonaldata.documents[i].data["Gender"];
          house=candidatepersonaldata.documents[i].data["House"] ;
          street=candidatepersonaldata.documents[i].data["Street"];
          city=candidatepersonaldata.documents[i].data["City"];
          state=candidatepersonaldata.documents[i].data["State"] ;
          country=candidatepersonaldata.documents[i].data["Country"];
          pin=  candidatepersonaldata.documents[i].data["Pin"];
        }
      }
      for( i1=0;i1<candidatestatusdata.documents.length;i1++)
      {
        if(widget.email==candidatestatusdata.documents[i1].documentID)
        {
          companyname=candidatestatusdata.documents[i1].data["Company Name"];
          role=candidatestatusdata.documents[i1].data["Role"];
          startdate=candidatestatusdata.documents[i1].data["Start Date"];
          status=candidatestatusdata.documents[i1].data["Status"];
          work=candidatestatusdata.documents[i1].data["Work"] ;
        }
      }
      for(c1=0;c1<appliedcandidatedata.documents.length;c1++)
        {
          if(widget.email==appliedcandidatedata.documents[c1].documentID)
            {
               reason=appliedcandidatedata.documents[c1].data['Reason For Apply'];
               interviewmode=appliedcandidatedata.documents[c1].data['Interview Mode'];
               interviewslot=appliedcandidatedata.documents[c1].data['Interview Slot'];
               noticeperiod=appliedcandidatedata.documents[c1].data['Notice Period'];
              break;
            }
        }


      return new WillPopScope(
          onWillPop: _onWillPop,
          child:Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),
            ),
          body: ListView(
            children: <Widget>[
              SizedBox(height: 20,),
           Row(

          children: <Widget>[
              SizedBox(width: 40.0),
            Container(

                width: 80.0,
                height: 80.0,
                child:  imageFile == null
                    ? GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 70.0,
                    backgroundImage: NetworkImage(url),
                  ),
                )
                    : GestureDetector(
                  child: CircleAvatar(
                    radius: 70.0,
                    backgroundImage: MemoryImage(imageFile),
                  ),

                ),),
            SizedBox(width: 20.0),
            Flexible(
              child: Text("${name}", style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  ),),

            ),
            ],),
              SizedBox(height: 20,),
              _buildTitle("Slot Information"),
              Container(
                height:250,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 15),
                              child: Text(" Reason for applying: ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 15.0),
                            child: Text("${reason}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),



                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 18),
                              child: Text(" Interview mode  selected: ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 12.0),
                            child: Text("${interviewmode}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 20),
                              child: Text("Interview slot selected : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 20),
                            child: Text("${interviewslot}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 20),
                              child: Text("Notice Period : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 20),
                            child: Text("${noticeperiod}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200
                ),

              ),
              SizedBox(height: 20,),
              _buildTitle("Current Status"),
              Container(
                height:200,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 8),
                              child: Text("Company Name: ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 10.0),
                            child: Text("${companyname}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 18),
                              child: Text(" Role : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 12.0),
                            child: Text("${role}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 20),
                              child: Text("Status : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 20),
                            child: Text("${status}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 20),
                              child: Text("Wok : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 20),
                            child: Text("${work}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 20),
                              child: Text("Start Date : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 20),
                            child: Text("${startdate}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200
                ),

              ),
              SizedBox(height: 20,),
              _buildTitle("Personal Details"),
              Container(
                height:200,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 8),
                              child: Text("Phone Number: ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 10.0),
                            child: Text("${phone}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 18),
                              child: Text("Second Phone Number : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 12.0),
                            child: Text("${phone2}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 20),
                              child: Text("Gender : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 20),
                            child: Text("${gender}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 20),
                              child: Text("Date Of Birth : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 20),
                            child: Text("${dob}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 5),
                              child: Text("Address : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,top: 15),
                            child: Text("${house} ${street} ${city} ${state} ${country} ${pin}",style:TextStyle(fontSize:15,fontFamily: 'BeVietnam') ,),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200
                ),

              ),
              _buildTitle("Education Details"),
              Container(
                height:double.parse("${candidateeducationdata.documents.length}")*110,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: candidateeducationdata.documents.length,
                    itemBuilder:(context, i){
                      print(candidateeducationdata.documents[i].data['College Name']);
                      return new ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 0.0, left: 20.0),
                            child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                          ),

                          title: Container(
                            margin: EdgeInsets.only(top: 10,left: 0.0),
                            child: Text("${candidateeducationdata.documents[i].data['College Name']}", style: TextStyle(
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
                                              TextSpan(text: 'Course : ', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BeVietnam')),
                                              TextSpan(text:"${candidateeducationdata.documents[i].data['Course Name']}",style: TextStyle(fontFamily: 'BeVietnam') ),
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
                                              TextSpan(text: 'Marks : ', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BeVietnam')),
                                              TextSpan(text:"${candidateeducationdata.documents[i].data['Marks']}",style: TextStyle(fontFamily: 'BeVietnam') ),
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
                                              TextSpan(text: 'Session : ', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BeVietnam')),
                                              TextSpan(text:"${candidateeducationdata.documents[i].data['Session']}",style: TextStyle(fontFamily: 'BeVietnam') ),
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),

                            ],
                          )
                      );
                    }
                ),
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200
                ),

              ),
              _buildTitle("Experience Details"),
              Container(
                height:double.parse("${candidateexperiencedata.documents.length}")*150,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:candidateexperiencedata.documents.length,
                    itemBuilder:(context, i){

                      return new ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 0.0, left: 20.0),
                            child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                          ),

                          title: Container(
                            margin: EdgeInsets.only(top: 10,left: 0.0),
                            child: Text("${candidateexperiencedata.documents[i].data['Role']}", style: TextStyle(
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
                                              TextSpan(text:"${candidateexperiencedata.documents[i].data['Company Name']}" ,style: TextStyle(fontFamily: 'BeVietnam')),
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
                                              TextSpan(text:"${candidateexperiencedata.documents[i].data['Duration']}",style: TextStyle(fontFamily: 'BeVietnam') ),
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
                                              TextSpan(text:"${candidateexperiencedata.documents[i].data['Details']}",style: TextStyle(fontFamily: 'BeVietnam') ),
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),

                            ],
                          )
                      );
                    }
                ),
              ),

              Container(
                height: 15,
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200
                ),

              ),
              _buildTitle("Skill Details"),
              SingleChildScrollView(
                child: Container(
                  height:double.parse("${candidateskilldata.documents.length}")*80,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: candidateskilldata.documents.length,
                      itemBuilder:(context, i){
                        return new ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 5.0, left: 20.0),
                              child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                            ),

                            title: Container(
                              margin: EdgeInsets.only(top: 0),
                              child: Text("${candidateskilldata.documents[i].data['Skill']}", style: TextStyle(
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
                                                TextSpan(text:"${candidateskilldata.documents[i].data['Level']}",style: TextStyle(fontFamily: 'BeVietnam') ),
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),


                              ],
                            )
                        );
                      }
                  ),
                ),
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200
                ),

              ),

              _buildTitle("Projects Details"),
              SingleChildScrollView(
                child: Container(

                  height:double.parse("${candidateprojectdata.documents.length}")*200,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: candidateprojectdata.documents.length,
                      itemBuilder:(context, i){
                        return new ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 5.0, left: 20.0),
                              child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                            ),

                            title: Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text("${candidateprojectdata.documents[i].data['Project Name']}", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BeVietnam'
                              ),),
                            ),

                            subtitle: Column(

                              children: <Widget>[
                                Row(

                                  children: <Widget>[
                                    Padding(padding: const EdgeInsets.only(top: 30.0,)),
                                    Container(
                                        child: Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              text: '',
                                              style: DefaultTextStyle.of(context).style,
                                              children: <TextSpan>[
                                                TextSpan(text: 'Description : ', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BeVietnam')),
                                                TextSpan(text:"${candidateprojectdata.documents[i].data['Project Details']}",style: TextStyle(fontSize: 12,fontFamily: 'BeVietnam')),
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                Row(

                                  children: <Widget>[
                                    Padding(padding: const EdgeInsets.only(top: 25.0,)),
                                    Container(
                                        child: Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              text: '',
                                              style: DefaultTextStyle.of(context).style,
                                              children: <TextSpan>[
                                                TextSpan(text: 'Link  :  ', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BeVietnam')),
                                                TextSpan(text:"${candidateprojectdata.documents[i].data['Link']}",style: TextStyle(fontSize: 12,fontFamily: 'BeVietnam')),
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                Row(

                                  children: <Widget>[
                                    Padding(padding: const EdgeInsets.only(top: 25.0,)),
                                    RaisedButton(
                                      color:Colors.green,
                                      child: Text("Click to know more",style: TextStyle(fontFamily: 'BeVietnam'),),
                                      onPressed:() async{
                                        String url = '${candidateprojectdata.documents[i].data['Link']}';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                    )
                                  ],
                                ),



                              ],
                            )
                        );
                      }
                  ),
                ),
              ),
            ],
          ),
          ));
    }else{
      return new WillPopScope(
        onWillPop: _onWillPop,
        child:Scaffold(
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            title: Center(child: const Text("Hire Easy")),
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
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewCandidate()));
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title.toUpperCase(), style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold
          ),),
          Divider(color: Colors.black54,),
        ],
      ),
    );
  }


}
