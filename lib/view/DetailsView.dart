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
    return new DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.contact_phone),
                text: 'Contacts',
              ),
              Tab(
                  icon: Icon(Icons.contact_page),
                  text: 'Professional Contacts'),
            ],
          ),
          title: Text('Contacts'),
        ),
        body: TabBarView(
          children: [
            PlanningDetail(
              description: "hello", title: title, table: "Contacts"),
            PlanningDetail(
              description: "hello", title: title, table: "ContactsP"),
          ],
        ),
      ),
    );
  }
}
