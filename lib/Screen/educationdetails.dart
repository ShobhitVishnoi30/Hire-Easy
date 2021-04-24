import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/Screen/mainprofile.dart';
import 'package:lotpickproject/constants.dart';
import 'package:lotpickproject/home.dart';
import 'package:lotpickproject/service.dart';

class EducationDetails extends StatefulWidget {
  @override
  _EducationDetailsState createState() => _EducationDetailsState();
}

class _EducationDetailsState extends State<EducationDetails> {
  String college,course,marks,session;
  crudMethods fobj=new crudMethods();
  QuerySnapshot educationdata;
  @override
  void initState() {
    fobj.geteducationdata().then((results) {
      setState(() {
        educationdata = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(educationdata!=null) {
      return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
      appBar: new AppBar(
      automaticallyImplyLeading: false,
      title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'))),

    ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Your Education Details",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BeVietnam',
                      fontSize: 20.0,
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
                            addeducationdetails(context);
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
                margin: EdgeInsets.only(left: 30),
                height:double.parse("${educationdata.documents.length}")*170,
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
                                              TextSpan(text:"${educationdata.documents[i].data['Session']}" ,style: TextStyle(fontFamily: 'BeVietnam'),),
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
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
                                              editeducationdetails(context,i);
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
                                              fobj.deleteEducationData(educationdata.documents[i].documentID);
                                              fobj.geteducationdata().then((results) {
                                                setState(() {
                                                  educationdata = results;
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
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(2)));
  }
  Future<dynamic>editeducationdetails(BuildContext context,int i) async {


    college="${educationdata.documents[i].data['College Name']}";
    course="${educationdata.documents[i].data['Course Name']}";
    marks="${educationdata.documents[i].data['Marks']}";
    session="${educationdata.documents[i].data['Session']}";

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Edit your Education Details",style: TextStyle(fontFamily: 'BeVietnam'),)),
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
                          hintText: '${course}',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.course = input,
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
                          hintText: '${college}',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.college = input,
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
                          hintText: '${marks}',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.marks = input,
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
                          hintText: '${session}',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.session = input,
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
                              fobj.editEducationData({
                                'College Name': this.college,
                                'Course Name': this.course,
                                'Marks': this.marks,
                                'Session':this.session,


                              },educationdata.documents[i].documentID).then((result) {
                              }).catchError((e) {
                                print(e);
                              });
                              fobj.geteducationdata().then((results) {
                                setState(() {
                                  educationdata = results;
                                });
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
  Future<dynamic>addeducationdetails(BuildContext context) async {


    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Enter your Education Details",style: TextStyle(fontFamily: 'BeVietnam'),)),
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
                          hintText: 'Enter Course',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.course = input,
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
                          hintText: 'Enter College name',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.college = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter marks(% / CGPA)',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.marks = input,
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Enter seesion of course(start-end)',
                          hintStyle: kHintTextStyle1,
                        ),
                        onChanged: (input) =>this.session = input,
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
                              fobj.addEducationData({
                                'College Name': this.college,
                                'Course Name': this.course,
                                'Marks': this.marks,
                                'Session':this.session,
                                'Email':fobj.user.email,

                              }).then((result) {
                              }).catchError((e) {
                                print(e);
                              });
                              fobj.geteducationdata().then((results) {
                                setState(() {
                                  educationdata = results;
                                });
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
