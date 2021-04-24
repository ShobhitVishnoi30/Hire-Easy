import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/Screen/jobdetails.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';

import '../constants.dart';
import '../home.dart';
import '../service.dart';

class ApplyForJob extends StatefulWidget {

  final int i;
  final String companyname,designation,company;
  ApplyForJob(this.i,this.companyname,this.designation,this.company);

  @override
  _ApplyForJobState createState() => _ApplyForJobState();
}

class _ApplyForJobState extends State<ApplyForJob> {
  bool checkBoxValue=false;
  crudMethods fobj=new crudMethods();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  QuerySnapshot jobdata,savedjobdata,educationdata,personaldata;
  FirebaseUser user;
  bool personaldetails=false,educationdetails=false;
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
    fobj.getsavedjobs().then((results) {
      setState(() {
        savedjobdata = results;
      });
    });
    fobj.geteducationdata().then((results){
      setState((){
        educationdata=results;
      });
    });
    fobj.getpersonaldata().then((results) {
      setState(() {
        personaldata = results;
      });
    });
    super.initState();
  }
int j;
  String reasonforapply,noticeperiod,selectinterviewslot,interviewmode;

  List dataSource1=[
    {
      "display": "Face to Face",
      "value": "Face to face",
    },
    {
      "display": "Video Conferencing",
      "value": "Video Conferencing",
    },
  ];
  int _radioValue = 0;
  String _result="Slot 1";
  void _handleRadioValueChange(int value) {
    int l1=widget.i;
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _result = '${ jobdata.documents[l1].data['Interview Slot1']} , ${ jobdata.documents[l1].data['Slot Timing 1']}';
          break;
        case 1:
          _result = '${ jobdata.documents[l1].data['Interview Slot2']} , ${ jobdata.documents[l1].data['Slot Timing 2']}';
          break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    if(jobdata!=null&&savedjobdata!=null&&educationdata!=null&&personaldata!=null){
      if(educationdata.documents.length>0){
        educationdetails=true;
      }
      for(int i=0;i<personaldata.documents.length;i++)
      {
        if(personaldata.documents[i].documentID==fobj.user.email)
        {

          personaldetails=true;

        }
      }
      j=widget.i;
      return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),
       ),
          body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 30.0),
                _buildreasonforapplyTF(),
                SizedBox(height: 30.0),
                _buildnoticeperiodTF(),
                SizedBox(height: 30.0),
                _buildinterviewslotTF(),
                SizedBox(height: 30.0),
                _buildinterviewmode(),
                SizedBox(height: 30.0),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      new Checkbox(value: checkBoxValue,
                          activeColor: Colors.green,
                          onChanged:(bool newValue){
                            setState(() {
                              checkBoxValue = newValue;
                            });
                          }),
                      Flexible(child: new Text("Consent to agree Job Requirement and details given",style: TextStyle(fontFamily: 'BeVietnam'),))
                    ],
                  ),
                ),
            Center(
                child:RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(28.0),
                      side: BorderSide(color: Colors.red)
                  ),
                  child: Text("Apply Now",style: TextStyle(fontFamily:'BeVietnam',fontWeight: FontWeight.bold,fontSize: 15.0),),
                onPressed: () {
                  if (checkBoxValue && _formKey.currentState.validate()) {
                    _formKey.currentState.save();

                   if (personaldetails && educationdetails) {
                      for (int k = 0; k < savedjobdata.documents.length; k++) {
                        if (jobdata.documents[j].documentID == savedjobdata
                            .documents[k].data['DocumentID']) {
                          Firestore.instance.collection('Saved Jobs').document(
                              '${fobj.user.email}')
                              .collection("savedjob")
                              .document("${savedjobdata.documents[k].documentID}")
                              .delete()
                              .catchError((e) {
                            print(e);
                          });
                        }
                      }
                      fobj.addCompanyJobResponse({
                        'Reason For Apply': this.reasonforapply,
                        'Notice Period': this.noticeperiod,
                        'Interview Slot': this._result,
                        'Interview Mode': this.interviewmode,
                        'Candidate Email': user.email,
                        'Designation': jobdata.documents[j].data['Designation'],
                      }, jobdata.documents[j].data['Email'], jobdata.documents[j]
                          .data['Designation'], user.email).then((result) {})
                          .catchError((e) {
                        print(e);
                      });
                      fobj.addAppliedJob({
                        'Reason For Apply': this.reasonforapply,
                        'Notice Period': this.noticeperiod,
                        'Interview Slot': this._result,
                        'Interview Mode': this.interviewmode,
                        'Candidate Email': user.email,
                        'Designation': jobdata.documents[j].data['Designation'],
                        'Company Email': jobdata.documents[j].data['Email'],
                        'Company Name': "${widget.companyname}",
                        'Status': "Applied",
                      }, user.email).then((result) {}).catchError((e) {
                        print(e);
                      });
                      _addDialog(context);
                    }else{
                      _completeprofile(context);
                    }
                  }else{

                    _addDialog1(context);
                  }

                }
                 ),
               ),
              ],
            ),
          ),
        )
    );
    }else{
      return new WillPopScope(
          onWillPop: _onWillPop,
          child:Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              title: Center(child: const Text("Hire Easy",style:TextStyle(fontFamily: 'BeVietnam'),)),
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
  Widget _buildreasonforapplyTF() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Why are you applying for the job?(Not more than 150 words).",
            style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 100.0,
            child: TextFormField(
              validator: validatefield,
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              onChanged: (value){
                this.reasonforapply=value;
              },
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),


              decoration: InputDecoration(

                border: InputBorder.none,

                contentPadding: EdgeInsets.only(top: 4.0,left: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildnoticeperiodTF() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Enter notice period",
            style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 50.0,
            child: TextFormField(
              validator: validatefield,
              onChanged: (value){
                this.noticeperiod=value;
              },
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),


              decoration: InputDecoration(
                border: InputBorder.none,

                contentPadding: EdgeInsets.only(top: 4.0,left: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildinterviewslotTF() {
    int k1=widget.i;
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Select interview slot",
            style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Container(
            margin: EdgeInsets.only(left: 0,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Radio(
                      activeColor: Colors.black,
                      value: 0,
                      groupValue:  _radioValue,
                      onChanged:_handleRadioValueChange ,
                    ),
                    new Text(
                      '${ jobdata.documents[k1].data['Interview Slot1']} , ${ jobdata.documents[k1].data['Slot Timing 1']}',
                      style: new TextStyle(fontSize: 16.0,fontFamily: 'BeVietnam'),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    new Radio(
                      activeColor: Colors.black,
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    new Text(
                      '${ jobdata.documents[k1].data['Interview Slot2']} , ${ jobdata.documents[k1].data['Slot Timing 2']}',
                      style: new TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'BeVietnam'
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildinterviewmode() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Select interview mode",
            style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Container(
            decoration: kBoxDecorationStyle,
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 50,
            width: 350,

            child:DropDownFormField(

              inputDecoration: InputDecoration.collapsed(

              ),

              value: interviewmode,
              onSaved: (value) {
                setState(() {
                  interviewmode = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  interviewmode = value;
                });
              },
              dataSource: dataSource1,
              textField: 'display',
              valueField: 'value',
            ),
          ),
        ],
      ),
    );
  }
  _completeprofile(BuildContext context){

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
                      child: new Text("Add your education details to improve your chances of getting selected",style: TextStyle(fontFamily: 'BeVietnam'),),
                    ),

                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add',style: TextStyle(fontFamily: 'BeVietnam')),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(2)));

                },
              ),
            ],
          );
        }
    );
  }

  Future<dynamic>_addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Successfully applied(Your details are shared with comapny)",style: TextStyle(fontFamily: 'BeVietnam'))),
            content: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left:90),
                    child: Center(
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("ok",style: TextStyle(fontSize: 20),),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(0)));
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
  String validatefield(String value) {
// Indian Mobile number are of 10 digit only

    if (value.length <= 0) {

      return 'mandatory field';
    }
    else {

      return null;
    }
  }
  Future<dynamic>_addDialog1(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("please fill all the fiels",style: TextStyle(fontFamily: 'BeVietnam'))),
            content: SingleChildScrollView(

                    child: Center(
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("ok",style: TextStyle(fontSize: 20),),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )


          );

        }


    );
  }
  Future<bool> _onWillPop() {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JobDetails(widget.i,widget.designation,widget.company)));
  }
}


