import 'package:flutter/material.dart';
import 'package:safety/homepage/homepage.dart';
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
      backgroundColor: Color(0xFFF6F8FC),
      appBar: AppBar(
        title: Text("Reminders"),
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('/'),
                );
              })
        ],
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
          //Medication(title: 'Medications'),
          HomePage(),
          Appointments(
            title: 'Appointments',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.greenAccent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        currentIndex: 1,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          switch (value) {
            case 0:
              {
                
                Navigator.pushNamed(context, '/SafetyPlan');
              }
              break;
            case 1:
              {
                Navigator.pushNamed(context, '/Reminders');
              }
              break;
            case 2:
              {
                Navigator.pushNamed(context, '/Resources');
              }
              break;
            case 3:
              {
                Navigator.pushNamed(context, '/Music');
              }
              break;
            default:
              {
                throw Error();
              }
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Safety Plan'),
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            title: Text('Remainders'),
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            title: Text('Resources'),
            icon: Icon(Icons.book),
          ),
          BottomNavigationBarItem(
            title: Text('Music'),
            icon: Icon(Icons.music_note),
          ),
        ],
      ),
    );
  }
}
