import 'package:flutter/material.dart';

class SafetyPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       body:ListView(
        children: [
         new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new Image.asset("assets/images/4070-ai.png") 
          ]
        ),
       
      

      Card(
  child: new InkWell(
    onTap: () {
      print("tapped");
    },
    child: Container(
      width: 100.0,
      height: 100.0,
    ),
  ),
),


      Card(
  child: new InkWell(
    onTap: () {
      print("tapped");
    },
    child: Container(
      width: 100.0,
      height: 100.0,
    ),
  ),
),


      Card(
  child: new InkWell(
    onTap: () {
      print("tapped");
    },
    child: Container(
      width: 100.0,
      height: 100.0,
    ),
  ),
),


      Card(
  child: new InkWell(
    onTap: () {
      print("tapped");
    },
    child: Container(
      width: 100.0,
      height: 100.0,
    ),
  ),
),


      Card(
  child: new InkWell(
    onTap: () {
      print("tapped");
    },
    child: Container(
      width: 100.0,
      height: 100.0,
    ),
  ),
),


      Card(
     
   child: new InkWell(
    onTap: () {
      print("tapped");
    },
    child: Container(
       width: 100.0,
      height: 100.0,
    ),
    
  ),
),
        ]
       ),
        
    );
  }
}
