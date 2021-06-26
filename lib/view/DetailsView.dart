import 'package:flutter/material.dart';
import 'package:safety/view/planningDetail.dart';

class Details extends StatelessWidget {
  final String title;
  final String description;
  final String table;

  const Details({Key key, this.title, this.description, this.table})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          title: Text(title),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(width: 2, color: Colors.white)),
        ),
        body: Center(
          child: PlanningDetail(
              description: description, title: title, table: table),
        ));
  }
}

class DetailsStatic extends StatelessWidget {
  final String title;

  const DetailsStatic({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          title: Text(title),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(width: 2, color: Colors.white)),
        ),
        body: Center(
            child: Text(
                "It is critical to make your environment safe by removing things you could use to hurt yourself. Either remove them yourself or talk to a truted friend or family member and have them remove objects such as guns, knives, razors, or pills. If you need pills regularly, your trusted friend or family member can give you the pills on an as-needed basis according to the prescription. If you have a specific plan in place, make sure to tell your trusted friend or family member about the plan so they can ensure your safety.")));
  }
}
