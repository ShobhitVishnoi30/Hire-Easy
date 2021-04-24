import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/Screen/mainprofile.dart';
import 'package:lotpickproject/home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../service.dart';

class DocumentDetails extends StatefulWidget {
  @override
  _DocumentDetailsState createState() => _DocumentDetailsState();
}

class _DocumentDetailsState extends State<DocumentDetails> {
  String document='',url='';
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  crudMethods fobj=new crudMethods();
  QuerySnapshot documentdata;
  File _imageFile;
  @override
  void initState() {
    fobj.getDocument().then((results) {
      setState(() {
        documentdata = results;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if(documentdata!=null) {
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
                      "Your Documents",
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
                              adddocumentdetails(context);
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

                  height:double.parse("${documentdata.documents.length}")*140,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: documentdata.documents.length,
                      itemBuilder:(context, i){
                        return new ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 5.0, left: 20.0),
                              child: Icon(FontAwesomeIcons.solidCircle, size: 12.0, color: Colors.black54,),
                            ),

                            title: Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text("${documentdata.documents[i].data['Document']}", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                fontFamily: 'BeVietnam',
                              ),),
                            ),

                            subtitle: Column(

                              children: <Widget>[
                                Row(

                                  children: <Widget>[
                                    Padding(padding: const EdgeInsets.only(top: 25.0,)),
                                    RaisedButton(
                                      color:Colors.green,
                                      child: Text("Click to see document",style: TextStyle(fontFamily: 'BeVietnam',),),
                                      onPressed:() async{
                                        String url = '${documentdata.documents[i].data['URL']}';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
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
                                              StorageReference storageReference = FirebaseStorage.instance.ref().child(fobj.user.email+"/${documentdata.documents[i].data['Document']}");

                                              storageReference.delete();
                                              fobj.deleteDocumentData(documentdata.documents[i].documentID);
                                              fobj.getDocument().then((results) {
                                                setState(() {
                                                  documentdata = results;
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
                                    )

                                  ],
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(width: 10,),

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
          title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam',),)),
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
  Future<dynamic>adddocumentdetails(BuildContext context) async {


    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Upload Your Documents",style: TextStyle(fontFamily: 'BeVietnam',),)),
            backgroundColor: Colors.white,
            content:SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(top: 30,bottom: 10,left: 0.0,right: 0.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        margin: EdgeInsets.all(20.0),
                        height: 60,
                        child: TextFormField(
                            validator: validatedocument,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(14.0),
                              hintText: 'Enter Document Name',
                              hintStyle: kHintTextStyle,
                            ),
                            onSaved: (input) {
                              this.document = input;


                            }
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(
                          children: <Widget>[
                            RaisedButton(onPressed: getImage,child: Text("get image",style: TextStyle(fontFamily: 'BeVietnam',),),color: Colors.blue,),
                            SizedBox(width: 10),
                            RaisedButton(onPressed: getFile,child: Text("Get File",style: TextStyle(fontFamily: 'BeVietnam',),),color: Colors.blue,)
                          ],
                        ),

                      ),

                      RaisedButton(

                        elevation: 7.0,
                        child: Text("Upload",style: TextStyle(fontFamily: 'BeVietnam',),),
                        textColor: Colors.white,
                        color: Colors.red,
                        onPressed: () async{

                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              if(_imageFile!=null) {
                              showLoadingDialog(context, _keyLoader);
                              final StorageReference firebaseStorgaeRef = FirebaseStorage
                                  .instance.ref().child(
                                  fobj.user.email + "/" + "${this.document}");
                              final StorageUploadTask task = firebaseStorgaeRef
                                  .putFile(
                                  _imageFile);
                              StorageTaskSnapshot taskSnapshot = await task
                                  .onComplete;
                              String url = await taskSnapshot.ref
                                  .getDownloadURL();
                              await Firestore.instance.collection("Documents")
                                  .document("${fobj.user.email}").collection(
                                  "document").document()
                                  .setData({
                                'Email': fobj.user.email,
                                'URL': url,
                                'Document': this.document,

                              });

                              Navigator.of(
                                  _keyLoader.currentContext,
                                  rootNavigator: true).pop();
                              showuploadDialog(context);
                              fobj.getDocument().then((results) {
                                setState(() {
                                  documentdata = results;
                                });
                              });
                            }else{
                                showerror(context);
                              }
                          }



                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 5,right: 7),
                            child: RaisedButton(
                                color: Colors.green,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: new Text("Cancel", style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'BeVietnam',))),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );


        }


    );

  }

  Future getImage() async {
    File image;
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image;
    });
  }
  Future getFile() async {
    File image;
    image = await FilePicker.getFile();
    setState(() {
      _imageFile = image;
    });
  }
  Future<dynamic>showuploadDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Document Uploaded",style: TextStyle(fontFamily: 'BeVietnam',),)),
            content: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left:70),
                    child: Center(
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("ok",style: TextStyle(fontSize: 20,fontFamily: 'BeVietnam',),),
                        onPressed: (){
                          Navigator.pop(context);
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
  Future<dynamic>showerror(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Pick Image/File",style: TextStyle(fontFamily: 'BeVietnam',),)),
            content: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left:70),
                    child: Center(
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("ok",style: TextStyle(fontSize: 20,fontFamily: 'BeVietnam',),),
                        onPressed: (){
                          Navigator.pop(context);
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
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait Uploading....",style: TextStyle(color: Colors.blueAccent,fontFamily: 'BeVietnam',),)
                      ]),
                    )
                  ]));
        });
  }
  String validatedocument(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length < 2) {

      return 'Provide document name';
    }
    else {

      return null;
    }
  }
}
