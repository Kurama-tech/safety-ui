import 'package:flutter/material.dart';

class SafetyPlan extends StatelessWidget {
  Widget containerData(IconData icon, String title, String subtitle) {
    return new Container(
        child: new InkWell(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      icon,
                      color: Colors.red[700],
                      size: 40,
                    ),
                    title: Text(title),
                    subtitle: Text(subtitle),
                  ),
                ],
              ),
            ),
            onTap: () {}));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(),
        body: ListView(children: [
          new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [new Image.asset("assets/images/4070-ai.png")]),
          containerData(Icons.warning, "Warning Signs",
              "Tap the Card to add warning signs"),
          containerData(Icons.music_note, "Coping Strategies",
              "Tap the Card to add coping strategies"),
          containerData(Icons.wb_sunny, "Reasons to Live",
              "Tap the Card to add things that are worth for living "),
          containerData(
              Icons.contact_phone, "Contacts", "Tap the Card to add contacts"),
          containerData(Icons.place, "Places for Distraction",
              "Tap the Card to add places that distract you"),
          containerData(Icons.grid_on, "Other",
              "Tap the Card to add any additionl notes that could helpful"),
          //containerData(icon, title, subtitle)
        ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.tealAccent[100],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (value) {
            // Respond to item press.
          },
          items: [
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text('Planning',
                  style: TextStyle(color: Colors.black.withOpacity(0.8))),
              icon: Icon(Icons.assignment, color: Colors.black),
            ),
            BottomNavigationBarItem(
              title: Text('Reminder',
                  style: TextStyle(color: Colors.black.withOpacity(0.8))),
              icon: Icon(Icons.calendar_today, color: Colors.black),
            ),
            BottomNavigationBarItem(
              title: Text('Resources',
                  style: TextStyle(color: Colors.black.withOpacity(0.8))),
              icon: Icon(Icons.inventory, color: Colors.black),
            ),
            BottomNavigationBarItem(
              title: Text('Music',
                  style: TextStyle(color: Colors.black.withOpacity(0.8))),
              icon: Icon(Icons.library_music, color: Colors.black),
            ),
          ],
        ));
  }
}
