import 'package:flutter/material.dart';
import 'package:safety/view/Appointments.dart';
import 'package:safety/view/Medications.dart';


class Reminders extends StatefulWidget {
  const Reminders({key}) : super(key: key);

  @override
  _RemindersState createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remainders"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(width: 2, color: Colors.white)),
        bottom: TabBar(
          indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 5.0)),
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
          labelColor: Theme.of(context).textTheme.headline4.color,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text("Medications"),
            ),
            Tab(
              child: Text("Appointments"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
           Medication(title: 'Medications'),
           Appointments(
              title: 'Appointments',
            ),
        ],
      ),
    );
  }
}
