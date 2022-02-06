import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homeView.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
       child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'image',
                child: Image.asset('assets/images/splash.png',width: MediaQuery.of(context).size.width/2.5,height: MediaQuery.of(context).size.width/2.5,),
              ),
              Padding(padding: EdgeInsets.all(15)),
               Hero(
                tag: 'text',
                child: Text("My Safety Plan",style: GoogleFonts.bioRhyme(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 50,
                                  color: Color(0xFF3EB16F),
                                  letterSpacing: 0.5),
                            ),),
              
               
            ],
          ),
          
        )
       // Image.asset('assets/images/splash.png',width: MediaQuery.of(context).size.width/2.5,height: MediaQuery.of(context).size.width/2.5,),
      
    );
  }
}
