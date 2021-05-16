import 'package:flutter/material.dart';

class Appointments extends StatefulWidget {
  Appointments({Key key, this.title}) : super(key: key);

  final String title;

  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        children: [],
      ),
    );
  }

  
}
