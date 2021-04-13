import 'package:flutter/material.dart';
import 'package:safety/view/homeView.dart';

class Reminders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
            backgroundColor: Colors.greenAccent,
            bottom: TabBar(
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
            backgroundColor: Colors.teal,
          ),
        ),
      ),
    );
  }
}
