import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Authentication/login.dart';




final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
getDetails c=new getDetails();
class crudMethods{


  FirebaseUser user;
  crudMethods(){
    user=c.getEmail();
  }




  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser()!=null){
      return true;
    }else{
      return false;
    }
  }
  Future<void>addPersonalData(userData)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Personal Data').document('${user.email}').setData(userData).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>addEducationData(userData)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Education Data').document('${user.email}').collection("education").document().setData(userData).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>addSkillData(userData)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Skill Data').document('${user.email}').collection("skill").document().setData(userData).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>addProjectData(userData)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Project Data').document('${user.email}').collection("project").document().setData(userData).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>addStatusData(userData)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Status').document('${user.email}').setData(userData).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>addExperienceData(userData)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Experience Data').document('${user.email}').collection("experience").document().setData(userData).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  getDocument() async {
    return await Firestore.instance.collection("Documents").document('${user.email}').collection("document").getDocuments();
  }
  getpersonaldata() async {
    return await Firestore.instance.collection("Personal Data").getDocuments();
  }
  getskilldata() async {
    return await Firestore.instance.collection("Skill Data").document("${user.email}").collection("skill").getDocuments();
  }
  getprojectdata() async {
    return await Firestore.instance.collection("Project Data").document("${user.email}").collection("project").getDocuments();
  }
  geteducationdata() async {
    return await Firestore.instance.collection("Education Data").document("${user.email}").collection("education").getDocuments();
  }
  getstatusdata() async {
    return await Firestore.instance.collection("Status").getDocuments();
  }
  getexperiencedata() async {
    return await Firestore.instance.collection("Experience Data").document("${user.email}").collection("experience").getDocuments();
  }
  Future<void>editEducationData(userData,String a)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Education Data').document('${user.email}').collection("education").document("${a}").setData(userData).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>deleteEducationData(String a)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Education Data').document('${user.email}').collection("education").document("${a}").delete().catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>editSkillData(userData,String a)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Skill Data').document('${user.email}').collection("skill").document("${a}").setData(userData).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>deleteSkillData(String a)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Skill Data').document('${user.email}').collection("skill").document("${a}").delete().catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>editProjectData(userData,String a)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Project Data').document('${user.email}').collection("project").document("${a}").setData(userData).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>deleteProjectData(String a)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Project Data').document('${user.email}').collection("project").document("${a}").delete().catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>editExperienceData(userData,String a)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Experience Data').document('${user.email}').collection("experience").document("${a}").setData(userData).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>deleteExperienceData(String a)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Experience Data').document('${user.email}').collection("experience").document("${a}").delete().catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>deleteDocumentData(String a)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Documents').document('${user.email}').collection("document").document("${a}").delete().catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>addCompanyData(userdata,String email)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Company Details').document('${email}').setData(userdata).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  getcompanydetails() async {
    return await Firestore.instance.collection("Company Details").getDocuments();
  }
  Future<void>addJobData(userdata)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Jobs').document().setData(userdata).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  getjobdata() async {
    return await Firestore.instance.collection("Jobs").getDocuments();
  }
  Future<void>addCompanyJobResponse(userdata,String email,String job,String useremail)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Company Job Response').document("${email}").collection("${job}").document("${user.email}").setData(userdata).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>addAppliedJob(userdata,String useremail)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Candidate Applied Jobs').document("${useremail}").collection("applied jobs").document().setData(userdata).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  getappliedjobdata() async {
    return await Firestore.instance.collection("Candidate Applied Jobs").document("${user.email}").collection("applied jobs").getDocuments();
  }
  getaddedjobdata() async {
    return await Firestore.instance.collection("Jobs").getDocuments();
  }
  getappliedcandidatedata(String job,String email) async {
    return await Firestore.instance.collection("Company Job Response").document("${email}").collection("${job}").getDocuments();
  }

  getcandidatepersonaldata() async {
    return await Firestore.instance.collection("Personal Data").getDocuments();
  }
  getcandidateskilldata(String email) async {
    return await Firestore.instance.collection("Skill Data").document("${email}").collection("skill").getDocuments();
  }
  getcandidateprojectdata(String email) async {
    return await Firestore.instance.collection("Project Data").document("${email}").collection("project").getDocuments();
  }
  getcandidateeducationdata(String email) async {
    return await Firestore.instance.collection("Education Data").document("${email}").collection("education").getDocuments();
  }
  getcandidateexperiencedata(String email) async {
    return await Firestore.instance.collection("Experience Data").document("${email}").collection("experience").getDocuments();
  }
  getcandidatestatusdata() async {
    return await Firestore.instance.collection("Status").getDocuments();
  }
  Future<void>addsavedjobs(userdata)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Saved Jobs').document("${user.email}").collection("savedjob").document().setData(userdata).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  getsavedjobs() async {
    return await Firestore.instance.collection("Saved Jobs").document("${user.email}").collection("savedjob").getDocuments();
  }

  Future<void>addchat(userdata)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Chat').document().setData(userdata).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>addchatuser(userdata,String recieveremail)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Chat User').document("${user.email}").collection("user").document("${recieveremail}").setData(userdata).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }
  Future<void>addchatuser1(userdata,String recieveremail)async{
    if(isLoggedIn()){
      Firestore.instance.collection('Chat User').document("${recieveremail}").collection("user").document("${user.email}").setData(userdata).catchError((e){
        print(e);
      });
    }else{
      print("you need to login");
    }
  }

  getchat() async {
    return await Firestore.instance.collection("Chat").getDocuments();
  }
  getchatuser() async {
    return await Firestore.instance.collection("Chat User").document("${user.email}").collection("user").getDocuments();
  }



}