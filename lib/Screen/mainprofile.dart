
import 'dart:io';
import 'dart:typed_data';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/Authentication/login.dart';

import 'package:lotpickproject/Screen/documentdetails.dart';
import 'package:lotpickproject/Screen/educationdetails.dart';
import 'package:lotpickproject/Screen/personaldetails.dart';
import 'package:lotpickproject/Screen/viewprofile.dart';
import 'package:lotpickproject/Screen/projectdetails.dart';
import 'package:lotpickproject/Screen/skilldetails.dart';
import 'package:lotpickproject/Screen/workexperience.dart';

import 'package:lotpickproject/service.dart';

import '../PrivacyPolicy.dart';

import '../help.dart';
import '../home.dart';

class Profile1 extends StatefulWidget {
  @override
  _Profile1State createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  crudMethods fobj=new crudMethods();
  QuerySnapshot statusdata,personaldata,skilldata,educationdata;
  bool perosnaldetials=false,educationdetails=false,statusdetials=false,skilldetails=false;
  StorageReference storageReference = FirebaseStorage.instance.ref().child("user_profile");

  Uint8List imageFile;
  File _image;



  saveImageToFirebase(a) {

    storageReference.child("image_${fobj.user.email}.jpg").putFile(_image);
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      saveImageToFirebase(fobj.user.email);
      fetchImageFromFirebase(fobj.user.email);
    });
  }



  fetchImageFromFirebase(a) {
    int maxSize = 5*1024*1024;
    storageReference.child("image_$a.jpg").getData(maxSize).then((value){
      setState(() {
        imageFile = value;
      });
    });
  }

  @override
  void initState() {
    fetchImageFromFirebase(fobj.user.email);
    fobj.getpersonaldata().then((results) {
      setState(() {
        personaldata = results;
      });
    });
    fobj.getstatusdata().then((results) {
      setState(() {
        statusdata = results;
      });
    });
    fobj.getskilldata().then((results) {
      setState(() {
        skilldata = results;
      });
    });
    fobj.geteducationdata().then((results) {
      setState(() {
        educationdata = results;
      });
    });


    super.initState();
  }

int selectedIndex=1;
  @override
  Widget build(BuildContext context) {
    if(personaldata!=null&&statusdata!=null&&educationdata!=null&&skilldata!=null) {
      if(skilldata.documents.length>0){
        skilldetails=true;
      }
      if(educationdata.documents.length>0){
        educationdetails=true;
      }
      for(int j=0;j<statusdata.documents.length;j++)
      {
        if(fobj.user.email==statusdata.documents[j].documentID)
        {

          statusdetials=true;

          break;
        }
      }
      return new WillPopScope(
        onWillPop: _onWillPop,
    child: Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10,),
            _buildcard(),
            SizedBox(height: 10,),
            _buildHeader(),
            Container(
              height: 15,
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200
              ),
            ),
            _buildTitle("Account Settings"),
            Center(
              child: Column(
                children: <Widget>[
                  new ListTile(
                      title: new Text("Personal Details",style: TextStyle(fontSize: 20,  fontFamily: 'BeVietnam',),),
                      trailing:Icon(Icons.account_box,color: Colors.red),

                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>PerosnalDetails()));
                      }),
                  Divider(thickness: 2,height: 0,),
                  new ListTile(
                      title: new Text("Education Details",style: TextStyle(fontSize: 20,  fontFamily: 'BeVietnam'),),
                      trailing:Icon(Icons.edit,color: Colors.red),

                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>EducationDetails()));
                      }),
                  Divider(thickness: 2,height: 0,),
                  new ListTile(
                      title: new Text("Skills",style: TextStyle(fontSize: 20,  fontFamily: 'BeVietnam'),),
                      trailing:Icon(Icons.book,color: Colors.red),

                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SkillDetails()));
                      }),
                  Divider(thickness: 2,height: 0,),
                  new ListTile(
                      title: new Text("Projects Details",style: TextStyle(fontSize: 20,  fontFamily: 'BeVietnam'),),
                      trailing:Icon(Icons.work,color: Colors.red),

                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ProjectDetails()));
                      }),
                  Divider(thickness: 2,height: 0,),
                  new ListTile(
                      title: new Text("Work Experience",style: TextStyle(fontSize: 20,  fontFamily: 'BeVietnam'),),
                      trailing:Icon(Icons.card_travel,color: Colors.red),

                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ExperienceDetails()));
                      }),
                  Divider(thickness: 2,height: 0,),
                  new ListTile(
                      title: new Text("Upload Assignment",style: TextStyle(fontSize: 20,  fontFamily: 'BeVietnam'),),
                      trailing:Icon(Icons.file_upload,color: Colors.red),

                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>DocumentDetails()));
                      }),
                  SizedBox(height: 20,),
                  _buildTitle("Support"),
                  Center(
                    child: Column(
                      children: <Widget>[
                        new ListTile(
                            title: new Text("Contact/Support",style: TextStyle(fontSize: 20,  fontFamily: 'BeVietnam'),),
                            trailing:Wrap(
                              children: <Widget>[
                                Icon(Icons.phone,color: Colors.red),
                                SizedBox(width: 5,),
                                Icon(Icons.message,color: Colors.red)
                              ],
                            ),

                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Help()));
                            }),



                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  _buildTitle("Legal"),
                  Center(
                    child: Column(
                      children: <Widget>[
                        new ListTile(
                            title: new Text("Terms Of Services",style: TextStyle(fontSize: 20,  fontFamily: 'BeVietnam'),),
                            trailing:Icon(Icons.book,color: Colors.red),

                            onTap: () {
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Privacy()));
                            }),
                        Divider(thickness: 2,height: 0,),
                        new ListTile(
                            title: new Text("Log Out",style: TextStyle(fontSize: 20),),
                            trailing:Icon(Icons.exit_to_app,color: Colors.red),

                            onTap: () {
                              _signOut();
                            }),
                        Divider(),

                      ],
                    ),
                  ),
                ],
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
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(0)));
  }

  Row _buildHeader() {
    int i,j,k;
    String name='',role='';
    for( i=0;i<personaldata.documents.length;i++)
    {
      if(fobj.user.email==personaldata.documents[i].documentID)
      {
        perosnaldetials=true;
        name=personaldata.documents[i].data['Name'];
        break;
      }
    }
    for( j=0;j<statusdata.documents.length;j++)
    {
      if(fobj.user.email==statusdata.documents[j].documentID)
      {

        role=statusdata.documents[j].data['Role'];

        break;
      }
    }
    return Row(

      children: <Widget>[
        SizedBox(width: 40.0),
        Container(

            width: 80.0,
            height: 80.0,
            child:imageFile == null
                  ? GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70.0,
                  child: Icon(Icons.add_a_photo, size: 40.0,),
                ),
                onTap: getImage,
              )
                  : GestureDetector(
                child: CircleAvatar(
                  radius: 70.0,
                  backgroundImage: MemoryImage(imageFile),
                ),
                onTap: getImage,
              ),
            ),
        SizedBox(width: 20.0),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("${name}", style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                fontFamily: 'BeVietnam'
              ),),
              SizedBox(height: 5.0),
              Text("${role} ",style: TextStyle(fontSize: 12,fontFamily: 'BeVietnam'),),
              Container(

                  child: FlatButton(
                      onPressed:(){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                      },
                      child:Text("View Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.red,fontFamily: 'BeVietnam'),)
                  )

              )
            ],
          ),
        ),


      ],);
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
  Widget _buildcard() {
    double percent=0.0;
    if(perosnaldetials)
      percent=percent+0.25;
    if(skilldetails)
      percent=percent+0.25;
    if(educationdetails)
      percent=percent+0.25;
    if(statusdetials)
      percent=percent+0.25;

    if(!perosnaldetials||!skilldetails||!educationdetails||!statusdetials) {

      return Center(
        child: Container(

          child:  Column(
            children: <Widget>[
              Text('Complete your profile',style: TextStyle(fontSize: 20),),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2500,
                  percent: percent,
                  center: Text("${percent*100}%",style: TextStyle(color: Colors.white)),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      );

    }
    else{
      return Center(
        child: Container(
          child:  Column(
            children: <Widget>[
              Text('Your profile is complete',style: TextStyle(fontSize: 20),),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2500,
                  percent: percent,
                  center: Text("${percent*100}%",style: TextStyle(color: Colors.white),),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
  Future<void> _signOut() async {
    try {
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      await _firebaseAuth.signOut().then((_){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    } catch (e) {
      print(e);
    }
  }
}
