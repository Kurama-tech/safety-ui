import 'package:flutter/material.dart';

class Medication extends StatefulWidget {
  Medication({Key key, this.title}) : super(key: key);

  final String title;

  _MedicationState createState() => _MedicationState();
}

class _MedicationState extends State<Medication>
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

