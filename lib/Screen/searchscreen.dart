import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/JobScreen/ShowAddedJobs.dart';
import 'package:lotpickproject/Screen/searchresult.dart';
import 'package:lotpickproject/constants.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';
import 'dart:async';

import '../service.dart';


class SearchPage extends StatefulWidget {
  SearchPage();

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData;
  QuerySnapshot companydata,jobdata;
  @override
  void initState(){

    fobj.getcompanydetails().then((results) {
      setState(() {
        companydata = results;
      });
    });
    fobj.getaddedjobdata().then((results) {
      setState(() {
        jobdata = results;
      });
    });
  }
  crudMethods fobj=new crudMethods();
  List<String> company = [];
  List<String> designation = [];
  String selected='',selecteddesignation='';

  @override
  Widget build(BuildContext context) {
    if(companydata!=null&&jobdata!=null) {
      for(int i=0;i<companydata.documents.length;i++){
        company.add(companydata.documents[i].data['Name']);
      }
      for(int i=0;i<jobdata.documents.length;i++){
        designation.add(jobdata.documents[i].data['Designation']);
      }
      return new WillPopScope(
        onWillPop: _onWillPop,
        child: FutureBuilder(
          future: buildFutures(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              default:
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  if (snapshot.data != null)
                    return Scaffold(

                        body: Container(
                          color: Colors.white,
                          constraints: BoxConstraints.expand(),
                          child: Form(
                              key: _formKey,
                              autovalidate: false,
                              child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[

                                      Divider(
                                          height: 10.0,
                                          color: Theme.of(context).primaryColor),
                                      Container(
                                        margin: EdgeInsets.all(20),
                                        child: DropDownField(
                                            value: selected,
                                            hintText: 'Select Company',
                                            hintStyle: kHintTextStyle,
                                            items: company,
                                            strict: false,
                                            setter: (dynamic newValue) {
                                              selected=newValue;

                                            }),
                                      ),
                                      Divider(
                                          height: 10.0,
                                          color: Theme.of(context).primaryColor),
                                      Container(
                                        margin: EdgeInsets.all(20),
                                        child: DropDownField(
                                            value: selecteddesignation,
                                            hintText: 'Select Designation',
                                            hintStyle: kHintTextStyle,
                                            items:designation,
                                            strict: false,
                                            setter: (dynamic newValue) {
                                              selecteddesignation=newValue;

                                            }),
                                      ),
                                      RaisedButton(
                                        color: Colors.pink,
                                        onPressed: (){
                                          if(_formKey.currentState.validate()){
                                            _formKey.currentState.save();
                                            if(selected!=''||selecteddesignation!='') {
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SearchResult(selecteddesignation,
                                                              selected)));
                                            }
                                          }else{
                                            _addDialog(context);
                                          }
                                        },
                                        child: Text("Search",style: TextStyle(color: Colors.white,fontFamily: 'BeVietnam'),),
                                      )
                                    ],
                                  ))),
                        ));
                  else
                    {
                      return new WillPopScope(
                        onWillPop: _onWillPop,
                        child: Scaffold(
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
            }
          }),
      );
    }else{
      return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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

  Future<bool> buildFutures() async {
    return true;
  }
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?',style: TextStyle(fontFamily: 'BeVietnam'),),
        content: new Text('Do you want to exit an App',style: TextStyle(fontFamily: 'BeVietnam'),),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',style: TextStyle(fontFamily: 'BeVietnam'),),
          ),
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes',style: TextStyle(fontFamily: 'BeVietnam'),),
          ),
        ],
      ),
    ) ??
        false;
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
                      child: new Text("Designation and Company both can not be empty",style: TextStyle(fontFamily: 'BeVietnam'),),
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