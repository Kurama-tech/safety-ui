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
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          Center(
            child: Wrap(
              alignment: WrapAlignment.end,
              children: [
                Medication(title: 'Medications'),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Add Medications'),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Wrap(
              alignment: WrapAlignment.end,
              children: [
                Appointments(
                  title: 'Appointments',
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _showStepper(context);
                    },
                    child: Text('Add Appointments'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showStepper(BuildContext context) async {
    int _index = 0;
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add an Appointment'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [Text("hello")],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
