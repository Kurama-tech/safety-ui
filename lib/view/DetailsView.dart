import 'package:flutter/material.dart';
import 'package:safety/view/planningDetail.dart';

class Details extends StatelessWidget {

  final String title;
  final String description;
  final String table;

  const Details({Key key, this.title, this.description, this.table}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(title),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(width: 2, color: Colors.white)),
      ),
      body: Center(child: PlanningDetail(description: description, title: title, table: table) ,)
      
      );
  }
  
}