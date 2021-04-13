import 'package:flutter/material.dart';


class Reminders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
            "Medications"),
                 ),
                Tab(
                  child: Text(
            "Appointments"),
            
                 ),
               
              ],
            ),
            title: Text('Reminders'),
          ),

        floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: const Icon(Icons.add),
        
        backgroundColor: Colors.teal,
         
        ),
        ),
      ),
    );
  }
}