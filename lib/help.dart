import 'package:flutter/material.dart';
import 'home.dart';
class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,

        child: Scaffold(
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            title: Center(child: const Text("Hire Easy",style: TextStyle(fontFamily: 'BeVietnam'),)),

          ),
          body: ListView(
            children: <Widget>[

              Container(

                  child: Center(child: Text("Contact with following",style:TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold,fontSize: 20)))),
              SizedBox(height: 20,),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text("Company Address : ",style:TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold,fontSize: 18))),
               Container(
                   margin: EdgeInsets.all(10),
                   child: Text("Lotpick Consulting Services Pvt Ltd\nNo-4, Kattigena Halli, Yelahanka\n Bengaluru, 560064",style:TextStyle(fontFamily: 'BeVietnam',))),
               Container(
                  margin: EdgeInsets.all(10),
                   child: Text("Email : ",style: TextStyle(fontFamily: 'BeVietnam',fontWeight: FontWeight.bold,fontSize: 18),)
               ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text("info@lotpick.com.",style: TextStyle(fontFamily: 'BeVietnam'),),
              )
            ],
          )
        )
    );
  }
  Future<bool> _onWillPop() {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(2)));
  }
}
