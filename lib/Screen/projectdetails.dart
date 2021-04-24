import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/Screen/mainprofile.dart';
import 'package:lotpickproject/constants.dart';
import 'package:lotpickproject/home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service.dart';
class ProjectDetails extends StatefulWidget {
  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  String projectname,link,projectdetails;
  crudMethods fobj=new crudMethods();
  QuerySnapshot projectdata;
  @override
  void initState() {
    fobj.getprojectdata().then((results) {
      setState(() {
        projectdata = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(projectdata!=null) {
      return new WillPopScope(
        onWillPop: _onWillPop,

        child: Scaffold(
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),

          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Your Projects",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'BeVietnam',
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 30,),
                    SizedBox.fromSize(
                      size: Size(46, 46), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.grey, // button color
                          child: InkWell(
                            splashColor: Colors.red, // splash color
                            onTap: () {
                              addprojectdetails(context);
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add,color: Colors.black,), // icon

                              ],
                            ),
                          ),
                        ),
                      ),
                    )

                  ],

                ),

                SizedBox(height: 30,),
                Container(

                  height:double.parse("${projectdata.documents.length}")*210,
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
                                SizedBox(height: 15,),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox.fromSize(
                                        size: Size(46, 46), // button width and height
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.grey, // button color
                                            child: InkWell(
                                              splashColor: Colors.red, // splash color
                                              onTap: () {
                                                editprojectdetails(context,i);
                                              }, // button pressed
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(Icons.edit,color: Colors.black,), // icon

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      SizedBox.fromSize(
                                        size: Size(46, 46), // button width and height
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.grey, // button color
                                            child: InkWell(
                                              splashColor: Colors.red, // splash color
                                              onTap: () {
                                                fobj.deleteProjectData(projectdata.documents[i].documentID);
                                                fobj.getprojectdata().then((results) {
                                                  setState(() {
                                                    projectdata = results;
                                                  });
                                                });
                                              }, // button pressed
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(Icons.delete,color: Colors.black,), // icon

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                )



                              ],
                            )
                        );
                      }
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    }else{return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(2)));
  }
  Future<dynamic>editprojectdetails(BuildContext context,int i) async {


    projectname="${projectdata.documents[i].data['Project Name']}";
    projectdetails="${projectdata.documents[i].data['Project Details']}";
     link="${projectdata.documents[i].data['Link']}";
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Edit your Project Details",style: TextStyle(fontFamily: 'BeVietnam'),)),
            backgroundColor: Colors.white,
            content:SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 30,bottom: 10,left: 0.0,right: 0.0),
                child: Column(
                  children: <Widget>[
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: '${projectname}',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.projectname = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: '${projectdetails}',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.projectdetails = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: '${link}',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.link = input,
                      ),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.of(context).pop();
                              fobj.editProjectData({
                                'Project Name': this.projectname,
                                'Project Details': this.projectdetails,
                                'Link': this.link,
                                'Email':fobj.user.email,
                              },projectdata.documents[i].documentID).then((result) {
                                fobj.getprojectdata().then((results) {
                                  setState(() {
                                    projectdata = results;
                                  });
                                });
                              }).catchError((e) {
                                print(e);
                              });

                            },
                            child: new Text("Submit", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(width: 35,),
                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Text("Cancel", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );


        }


    );
  }
  Future<dynamic>addprojectdetails(BuildContext context) async {


    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Enter your project details",style: TextStyle(fontFamily: 'BeVietnam'),)),
            backgroundColor: Colors.white,
            content:SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 30,bottom: 10,left: 0.0,right: 0.0),
                child: Column(
                  children: <Widget>[
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter Project Name',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.projectname = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter Details Of Project',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.projectdetails = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter link to your project',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.link = input,
                      ),
                    ),

                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.of(context).pop();
                              fobj.addProjectData({
                                'Project Name': this.projectname,
                                'Project Details': this.projectdetails,
                                'Link': this.link,


                              }).then((result) {
                                fobj.getprojectdata().then((results) {
                                  setState(() {
                                    projectdata = results;
                                  });
                                });
                              }).catchError((e) {
                                print(e);
                              });

                            },
                            child: new Text("Submit", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                        SizedBox(width: 35,),
                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Text("Cancel", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam'))),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );


        }


    );
  }


}



