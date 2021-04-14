import 'package:flutter/material.dart';
import "package:safety/model/planningModel.dart";

class PlanningScreen extends StatelessWidget {
  final List<PlanningModel> desc;

  //requiring the list of todos
  PlanningScreen({Key key, @required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //passing in the ListView.builder
      body: ListView.builder(
        itemCount: desc.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(desc[index].title)
          );
        },
      ),
    );
  }
}