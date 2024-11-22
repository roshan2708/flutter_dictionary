import 'dart:async';

import 'package:dictionary_app/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>DictionaryHomePage()),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(255, 250, 230, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Center(
          child: Container(
            
            
          
            child: Column(
              children: [
                Text("Define It" , style: TextStyle(fontSize: 72 , fontWeight: FontWeight.bold),),
                Text("I can't think what I have to write over here" , style: TextStyle(fontSize: 18 , color: Colors.grey[700]),),
              ],
            ),
          ),
        )
      ],),
    );
  }
}