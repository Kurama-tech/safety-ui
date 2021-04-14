import 'package:flutter/material.dart';

class SafetyPlan extends StatelessWidget {
  Widget containerData(IconData icon, String title, String subtitle) {
    return new Container(
        child: new InkWell(
            splashColor: Colors.greenAccent,
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
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(width: 2, color: Colors.white)),
      ),
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
    );
  }
}
