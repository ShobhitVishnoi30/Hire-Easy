import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home.dart';
import '../service.dart';
import 'candidatechat.dart';


class CandidateChatPage extends StatefulWidget {
  @override
  _CandidateChatPageState createState() => _CandidateChatPageState();
}

class _CandidateChatPageState extends State<CandidateChatPage> {


  crudMethods fobj=new crudMethods();
  QuerySnapshot chatuserdata,companydata,candidatedata,chatdata;
  String companyname;

  @override
  void initState() {
    fobj.getchatuser().then((results) {
      setState(() {
        chatuserdata = results;
      });
    });
    fobj.getpersonaldata().then((results){
      setState((){
        candidatedata=results;
      });
    });
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(chatuserdata!=null&&candidatedata!=null&&companydata!=null&&chatdata!=null) {
      if(chatuserdata.documents.length>0) {
        return new WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),
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
            body: ListView.builder(
              itemCount: chatuserdata.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildchat(context, index),
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
                  child: Text("No chat to display",style: TextStyle(fontFamily: 'BeVietnam'),)
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
        ),
      );
    }
  }
  _launchURL() async {
    const url = 'https://hire-3fa8d.web.app/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> _onWillPop() {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(0)));
  }
  Widget buildchat(BuildContext context, int i) {
    String candidatename='NIL';
    int count=0;
    companyname=null;
    for(int k=0;k<companydata.documents.length;k++)
    {
      if(chatuserdata.documents[i].data['reciever email']==companydata.documents[k].documentID)
      {
        companyname=companydata.documents[k].data['Name'];
        break;
      }
    }
    for(int k=0;k<candidatedata.documents.length;k++)
    {
      if(chatuserdata.documents[i].data['reciever email']==candidatedata.documents[k].documentID)
      {
        candidatename=candidatedata.documents[k].data['Name'];
        break;
      }
    }
    for(int k=0;k<chatdata.documents.length;k++)
    {
      if(chatdata.documents[k].data['reciever']==fobj.user.email&&chatuserdata.documents[i].data['reciever email']==chatdata.documents[k].data['sender']){
        if(!chatdata.documents[k].data['isseen']){
          count++;
        }
      }
    }

    return new Container(
      margin: EdgeInsets.all(5),

      child: GestureDetector(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CandidateChat("${chatuserdata.documents[i].data['reciever email']}")));
        },
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(companyname!=null?companyname:candidatename,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BeVietnam',
                    fontSize: 15.0),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Container(
                      height:20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:count!=0?Colors.green:Colors.white),
                      child: Center(child: Text(count!=0?"${count}":'')))
                ],
              ),
            ),
            Divider(thickness: 2,height: 0,),
          ],

        ),
      ),
    );
  }
}

