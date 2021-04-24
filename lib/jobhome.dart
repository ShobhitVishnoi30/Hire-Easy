import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/jobtabs.dart';
import 'package:lotpickproject/service.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Authentication/login.dart';

class JobHome extends StatefulWidget {

   final int _currentIndex1;
   JobHome(this._currentIndex1);
  @override
  _JobHomeState createState() => _JobHomeState();
}

class _JobHomeState extends State<JobHome> {

  crudMethods fobj=new crudMethods();
  String name='';

  String url='https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png';
  QuerySnapshot companydata,chatdata;
  FirebaseUser currentuser;
  int _currentIndex;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      currentuser = userData;
    });
  }
  int k;
  @override
  void initState() {
    getUserData();
    fobj.getcompanydetails().then((results) {
      setState(() {
        companydata = results;
      });
    });
    fobj.getchat().then((results){
      setState((){
        chatdata=results;
      });
    });
    _currentIndex=widget._currentIndex1;
    super.initState();
   // _currentIndex=widget.initialcurrentIndex;
  }


int count=0;
  @override
  Widget build(BuildContext context) {
     count=0;
    // TODO: implement build
    if(companydata!=null&&chatdata!=null) {
      for(int i=0;i<companydata.documents.length;i++)
      {
        if(currentuser.email==companydata.documents[i].documentID)
        {
          name=companydata.documents[i].data['Name'];

          break;
        }
      }
      for(int k=0;k<chatdata.documents.length;k++)
      {
        if(chatdata.documents[k].data['reciever']==fobj.user.email){
          if(!chatdata.documents[k].data['isseen']){
            count++;
          }
        }
      }
      return new WillPopScope(
        onWillPop: _onWillPop,
        child:Scaffold(
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            title: Center(child: const Text("           Hire Easy")),
            actions: <Widget>[
              IconButton(
                icon: new Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      new Icon(Icons.video_call),
                    ]
                ),
                onPressed: _launchURL,
              )
            ],
          ),
          body: new Container(
            child: Jobtabs[_currentIndex],
          ),
          bottomNavigationBar: new BottomNavigationBar(
            currentIndex: _currentIndex,
            iconSize: 30,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: new Icon(Icons.card_travel),
                  title: new Text("Added Jobs"),
                  backgroundColor: Colors.pinkAccent
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.card_travel),
                title: new Text("Add Jobs"),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.account_circle),
                title: new Text("Profile"),
              ),
              BottomNavigationBarItem(
                icon: new Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      new Icon(Icons.message),
                      new Positioned(
                          top: -1.0,
                          right: -6.0,
                          child: new Container(
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(4.0), color: Colors.red),
                            width: 16.0,
                            child: Center(
                              child: new Text(
                               "${count}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ))
                    ]
                ),
                title: new Text("Messages"),
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      );
    }else{
      return Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: const Text("           Hire Easy")),
          actions: <Widget>[
            IconButton(
              icon: new Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    new Icon(Icons.video_call),
                  ]
              ),
              onPressed: _launchURL,
            )
          ],
        ),
        body: Center(
          child: LoadingBouncingGrid.circle(
            size: 30,
            backgroundColor: Colors.blue,
          ),
        ),
        bottomNavigationBar: new BottomNavigationBar(
          currentIndex: _currentIndex,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: new Icon(Icons.card_travel),
                title: new Text("Added Jobs"),
                backgroundColor: Colors.pinkAccent
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.card_travel),
              title: new Text("Add Jobs"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text("Profile"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.message),
              title: new Text("Messages"),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      );
    }

  }
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }
  _launchURL() async {
    const url = 'https://hire-3fa8d.web.app/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}