import 'package:flutter/material.dart';

import 'cofee.dart';
import 'home.dart';
void main(){
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:  HomeScreen(),
      debugShowCheckedModeBanner: false,
      );

  }
}