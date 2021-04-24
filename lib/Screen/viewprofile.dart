
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/Screen/mainprofile.dart';
import 'package:lotpickproject/Screen/homepage.dart';
import 'package:lotpickproject/service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  crudMethods fobj=new crudMethods();
  int selectedIndex = 1;
  QuerySnapshot personaldata,projectdata,educationdata,skilldata,statusdata,experiencedata,profilephoto;
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
    fobj.getprojectdata().then((results) {
      setState(() {
        projectdata = results;
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
    fobj.getstatusdata().then((results) {
      setState(() {
        statusdata = results;
      });
    });
    fobj.getexperiencedata().then((results) {
      setState(() {
        experiencedata = results;
      });
    });
    super.initState();
  }
  int i,j,k,i1;
  String phone='',phone2='',gender='',house='',street='',city='',state='',country='',pin='',companyname='',dob='',role='',work='',status='',startdate='';
  @override
  Widget build(BuildContext context){
    if(personaldata!=null&&skilldata!=null&&projectdata!=null&&statusdata!=null&&experiencedata!=null&&educationdata!=null) {
      print(fobj.user.email);
      for( i=0;i<personaldata.documents.length;i++)
        {
          if(fobj.user.email==personaldata.documents[i].documentID)
            {
              phone=personaldata.documents[i].data["Phone"];
                  phone2=personaldata.documents[i].data["Second Phone"];
                  gender=personaldata.documents[i].data["Gender"];
                  house=personaldata.documents[i].data["House"] ;
                    street=personaldata.documents[i].data["Street"];
              city=personaldata.documents[i].data["City"];
              state=personaldata.documents[i].data["State"] ;
                  country=personaldata.documents[i].data["Country"];
                  pin=  personaldata.documents[i].data["Pin"];
              dob=  personaldata.documents[i].data["DOB"];
            }
        }
      for( i1=0;i1<statusdata.documents.length;i1++)
      {
        if(fobj.user.email==statusdata.documents[i1].documentID)
        {
          companyname=statusdata.documents[i1].data["Company Name"];
          role=statusdata.documents[i1].data["Role"];
          startdate=statusdata.documents[i1].data["Start Date"];
          status=statusdata.documents[i1].data["Status"];
          work=statusdata.documents[i1].data["Work"] ;
        }
      }

      return new WillPopScope(
      onWillPop: _onWillPop,
          child: Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: const Text("Gynnasy",style: TextStyle(fontFamily: 'BeVietnam'),)),
      ),
      body: SingleChildScrollView(
        child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            _buildHeader(),
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
            Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20,top: 5),
                            child: Text(" Company Name : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 5.0),
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
                            margin: EdgeInsets.only(left: 20,top: 15),
                            child: Text(" Role : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 15.0),
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
                            child: Text("Work : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
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
            _buildTitle("Personal Details"),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
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
                                margin: EdgeInsets.only(left: 20,top: 15),
                                child: Text("Secondary Phone Number : ",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'BeVietnam') ,),
                              ),
                            ],
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(left: 10,top: 15.0),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                            child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                          ),
                         Row(
                           children: <Widget>[
                             Container(
                               margin: EdgeInsets.only(left: 20,top: 15),
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
            _buildTitle("Education Details",),
            Container(
              height:double.parse("${educationdata.documents.length}")*110,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: educationdata.documents.length,
                  itemBuilder:(context, i){

                    return new ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 0.0, left: 20.0),
                          child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                        ),

                        title: Container(
                          margin: EdgeInsets.only(top: 10,left: 0.0),
                          child: Text("${educationdata.documents[i].data['College Name']}", style: TextStyle(
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
                                            TextSpan(text:"${educationdata.documents[i].data['Course Name']}",style: TextStyle(fontFamily: 'BeVietnam') ),
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
                                            TextSpan(text:"${educationdata.documents[i].data['Marks']}",style: TextStyle(fontFamily: 'BeVietnam') ),
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
                                            TextSpan(text:"${educationdata.documents[i].data['Session']}",style: TextStyle(fontFamily: 'BeVietnam') ),
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
              height:double.parse("${experiencedata.documents.length}")*150,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
               itemCount: experiencedata.documents.length,
             itemBuilder:(context, i){

               return new ListTile(
                 leading: Padding(
                   padding: const EdgeInsets.only(top: 0.0, left: 20.0),
                   child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                 ),

                 title: Container(
                   margin: EdgeInsets.only(top: 10,left: 0.0),
                   child: Text("${experiencedata.documents[i].data['Role']}", style: TextStyle(
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
                                   TextSpan(text:"${experiencedata.documents[i].data['Company Name']}",style: TextStyle(fontFamily: 'BeVietnam') ),
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
                                     TextSpan(text:"${experiencedata.documents[i].data['Duration']}",style: TextStyle(fontFamily: 'BeVietnam') ),
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
                                     TextSpan(text:"${experiencedata.documents[i].data['Details']}",style: TextStyle(fontFamily: 'BeVietnam') ),
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
                height:double.parse("${skilldata.documents.length}")*80,
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
                                              TextSpan(text:"${skilldata.documents[i].data['Level']}" ,style: TextStyle(fontFamily: 'BeVietnam')),
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

                height:double.parse("${projectdata.documents.length}")*200,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: projectdata.documents.length,
                    itemBuilder:(context, i){
                      return new ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 20.0),
                            child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                          ),

                          title: Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Text("${projectdata.documents[i].data['Project Name']}", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'

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
                                              TextSpan(text:"${projectdata.documents[i].data['Project Details']}",style: TextStyle(fontSize: 12,fontFamily: 'BeVietnam')),
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
                                              TextSpan(text:"${projectdata.documents[i].data['Link']}",style: TextStyle(fontSize: 12,fontFamily: 'BeVietnam')),
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
                                     String url = '${projectdata.documents[i].data['Link']}';
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
            SizedBox(height: 20.0),
          ],
        ),
      ),
    ),
    );
    }else{
      return Scaffold(
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
      );
    }

  }
  Future<bool> _onWillPop() {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(2)));
  }



  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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


  Row _buildHeader() {
    int i,j;
    String name='',role='',company='';
    for( i=0;i<personaldata.documents.length;i++)
    {
      if(fobj.user.email==personaldata.documents[i].documentID)
      {
        name=personaldata.documents[i].data['Name'];
        break;
      }
    }
    for( j=0;j<statusdata.documents.length;j++)
    {
      if(fobj.user.email==statusdata.documents[j].documentID)
      {
        role=statusdata.documents[j].data['Role'];
        company=statusdata.documents[j].data['Company Name'];
        break;
      }
    }
    return Row(

      children: <Widget>[
      SizedBox(width: 60.0),
      Container(

          width: 80.0,
          height: 80.0,
          child: imageFile == null
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
          ),),
      SizedBox(width: 20.0),
    Flexible(
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("${name}", style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'BeVietnam'
            ),),
            SizedBox(height: 10.0),
            Text("${role} ",style: TextStyle(fontFamily: 'BeVietnam'),),
            SizedBox(height: 5.0),
            Text("${company}",style: TextStyle(fontFamily: 'BeVietnam'),),
          ],
        )
      ),
    )
    ],);
  }





}