import 'package:flutter/material.dart';
import 'package:safety/view/DetailsView.dart';

class SafetyPlan extends StatelessWidget {
  Widget containerData(BuildContext context, IconData icon, String title,
      String subtitle, String table) {
    String description = '';
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
            onTap: () {
              switch (table) {
                case 'Warning':
                  {
                    description = 'i am in Warning';
                  }
                  break;
                case 'Coping':
                  {
                    description = 'i am in Coping';
                  }
                  break;
                case 'Reasons':
                  {
                    description = 'i am in reasons';
                  }
                  break;
                case 'Places':
                  {
                    description = 'i am in Places';
                  }
                  break;
                case 'Notes':
                  {
                    description = 'i am in Notes';
                  }
                  break;
                case 'Contacts':
                  {
                    description = 'i am in Contacts';
                  }
                  break;
                default:
                  {
                    print("Invalid choice");
                  }
                  break;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details(
                    title: title,
                    description: subtitle,
                    table: table,
                  ),
                ),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Safety Plan"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(width: 2, color: Colors.white)),
      ),
      body: ListView(children: [
        new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [new Image.asset("assets/images/4070-ai.png")]),
        containerData(context, Icons.warning, "Warning Signs",
            "Tap the Card to add warning signs", 'Warning'),
        containerData(context, Icons.music_note, "Coping Strategies",
            "Tap the Card to add coping strategies", 'Coping'),
        containerData(context, Icons.wb_sunny, "Reasons to Live",
            "Tap the Card to add things that are worth for living", 'Reasons'),
        containerData(context, Icons.contact_phone, "Contacts",
            "Tap the Card to add contacts", 'Contacts'),
        containerData(context, Icons.place, "Places for Distraction",
            "Tap the Card to add places that distract you", 'Places'),
        containerData(
            context,
            Icons.grid_on,
            "Other",
            "Tap the Card to add any additionl notes that could helpful",
            'Notes'),
        //containerData(icon, title, subtitle)
      ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF3EB16F),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        selectedFontSize: 14,
        currentIndex: 0,
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
                Navigator.pushNamed(context, '/Resources');
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
