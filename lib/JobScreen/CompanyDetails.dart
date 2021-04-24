import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/JobScreen/profile.dart';
import 'package:lotpickproject/service.dart';

import '../constants.dart';
import '../jobhome.dart';

class CompanyDetails extends StatefulWidget {
  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  FirebaseUser user;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
    });
  }
  QuerySnapshot companydata;
  @override
  void initState(){
    getUserData();
    fobj.getcompanydetails().then((results) {
      setState(() {
        companydata = results;
      });
    });
  }
  crudMethods fobj=new crudMethods();
  String name='',details='';
  @override
  Widget build(BuildContext context) {
    if(companydata!=null) {
        for(int i=0;i<companydata.documents.length;i++)
        {
          if(user.email==companydata.documents[i].documentID)
          {
            name=companydata.documents[i].data['Name'];
            details=companydata.documents[i].data['About'];
            break;
          }
        }
      return new WillPopScope(
        onWillPop: _onWillPop,
    child:Scaffold(
      appBar: new AppBar(
        title: Text("Hire Easy",style: TextStyle(fontFamily:'BeVietnam'),),
      ),
      body: ListView(

        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Text(
                  "Edit Your Details",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'BeVietnam',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                _buildcompanynameTF(),
                SizedBox(height: 30.0),
                _buildaboutTF(),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          fobj.addCompanyData({
                            'Name': this.name,
                            'About': this.details,
                          },user.email).then((result) {
                          }).catchError((e) {
                            print(e);
                          });
                          _addDialog1(context);
                        },
                        child: Center(
                          child: new Text("Submit", style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam')),
                        )),
                  ],
                ),
              ],
            ),
          )
        ],
      )
    ),
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
            child: LoadingBouncingGrid.circle(
              size: 30,
              backgroundColor: Colors.blue,
            ),
          ),
        ),
      );
    }

  }
  Future<dynamic>_addDialog1(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Updated Successfully",style: TextStyle(fontFamily: 'BeVietnam'),)),
            content: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left:70),
                    child: Center(
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("ok",style: TextStyle(fontSize: 20,fontFamily: 'BeVietnam'),),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JobHome(2)));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );

        }


    );
  }

  Future<bool> _onWillPop() {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JobHome(2)));
  }

  Widget _buildcompanynameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter Your Company Name",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (value){
              this.name=value;
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BeVietnam',
            ),


            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '${name}',
              contentPadding: EdgeInsets.only(top: 4.0,left: 4),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildaboutTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter about your company",
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(

          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          margin: EdgeInsets.only(top: 10),
          height: 150,
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              hintText: '${details}',
              hintStyle: kHintTextStyle1,
            ),
            onChanged: (input) =>this.details = input,
          ),
        ),
      ],
    );
  }

}
