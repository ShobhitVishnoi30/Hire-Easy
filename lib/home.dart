
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lotpickproject/Screen/savedjobs.dart';
import 'package:lotpickproject/service.dart';
import 'package:lotpickproject/tab.dart';
import 'Authentication/login.dart';
import 'Screen/appliedjobs.dart';
import 'Screen/chatpagecandidate.dart';
import 'Screen/editprofile.dart';
import 'Screen/homepage.dart';
import 'Screen/mainprofile.dart';
import 'Screen/status.dart';

class Home extends StatefulWidget {
  final int initialcurrentIndex;
  Home(this.initialcurrentIndex);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  crudMethods fobj=new crudMethods();
  String name='';

  String url='https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png';
  QuerySnapshot personaldata,chatdata;
  FirebaseUser currentuser;
  int _currentIndex;
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

  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      currentuser = userData;
    });
  }
 int k;
  @override
  void initState() {
    fetchImageFromFirebase(fobj.user.email);
    getUserData();
    fobj.getpersonaldata().then((results) {
      setState(() {
        personaldata = results;
      });
    });
    fobj.getchat().then((results){
      setState((){
        chatdata=results;
      });
    });

    _currentIndex=widget.initialcurrentIndex;
    super.initState();

  }
  int count=0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(personaldata!=null&&chatdata!=null) {
      for(int k=0;k<chatdata.documents.length;k++)
      {
        if(chatdata.documents[k].data['reciever']==fobj.user.email){
          if(!chatdata.documents[k].data['isseen']){
            count++;
          }
        }
      }
      for(int i=0;i<personaldata.documents.length;i++)
      {
        if(personaldata.documents[i].documentID==fobj.user.email)
        {

          name=personaldata.documents[i].data['Name'];

        }
      }

      return new WillPopScope(
      onWillPop: _onWillPop,
      child:Scaffold(
        appBar: new AppBar(
          title: Center(child: const Text("Gynnasy",style: TextStyle(fontFamily:'BeVietnam'),)),
          actions: <Widget>[
            IconButton(
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
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>CandidateChatPage()));
              },
            )
          ],
        ),
        body: new Container(
          child: tabs[_currentIndex],
        ),
        drawer:new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("${name}",style: TextStyle(fontFamily:'BeVietnam')),
                accountEmail: new Text("${fobj.user.email}",style: TextStyle(fontFamily:'BeVietnam')),
                currentAccountPicture:imageFile == null
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
              new ListTile(
                  leading: Icon(Icons.edit,color: Colors.red,),
                  title: new Text("Edit Profile",style: TextStyle(fontSize: 15,fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>EditProfile()));
                  }),
              new Divider(),
              new ListTile(
                  leading: Icon(Icons.save,color: Colors.red),
                  title: new Text("Saved Assignement",style: TextStyle(fontSize: 15,fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SavedJobs()));
                  }),

              new Divider(),
              new ListTile(
                  leading: Icon(Icons.history,color: Colors.red),
                  title: new Text("Status",style: TextStyle(fontSize: 15,fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>StatusPage()));
                  }),

              new Divider(),
              new ListTile(
                  leading: Icon(Icons.power_settings_new,color: Colors.red),
                  title: new Text("Logout",style: TextStyle(fontSize: 15,fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
                  onTap: () {
                    _signOut();
                  }),
            ],
          ),
        ),
        bottomNavigationBar: new BottomNavigationBar(
          currentIndex: _currentIndex,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: new Icon(Icons.card_travel),
                title: new Text("Classes",style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
                backgroundColor: Colors.pinkAccent
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.card_travel),
              title: new Text("Pending Assignment",style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text("Profile",style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              title: new Text("Search",style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
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
          title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),
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
                title: new Text("Classes",style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
                backgroundColor: Colors.pinkAccent
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.card_travel),
              title: new Text("Pending Assignment",style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text("Profile",style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              title: new Text("Search",style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold),),
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