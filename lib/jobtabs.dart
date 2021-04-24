import 'package:flutter/material.dart';
import 'package:lotpickproject/Screen/homepage.dart';

import 'JobScreen/AddJob.dart';
import 'JobScreen/ShowAddedJobs.dart';
import 'JobScreen/chatpage.dart';
import 'JobScreen/profile.dart';

final Jobtabs =[
  Center(child: AddedJobs()),
  Center(child: AddJob()),
  Center(child: JobProfile()),
  Center(child: ChatPage()),

];