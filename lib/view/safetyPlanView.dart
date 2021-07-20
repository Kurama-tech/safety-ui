import 'package:flutter/material.dart';
import 'package:safety/view/DetailsView.dart';

class SafetyPlan extends StatelessWidget {

  Widget containerDataStatic(BuildContext context, IconData icon, String title,
      String subtitle) {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsStatic(
                    title: title,
                  ),
                ),
              );
            }));
  }

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
                case 'ContactsP':
                  {
                    description = 'i am in ContactsP';
                  }
                  break;
                case 'Environment':
                  {
                    description = 'i am in Safe Environment';
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
      backgroundColor: Color(0xFFF6F8FC),
      appBar: AppBar(
        title: Text("Safety Plan"),
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              })
        ],
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
        containerData(context, Icons.place, "Places for Distraction",
            "Tap the Card to add places that distract you", 'Places'),
        
        containerDataStatic(context, Icons.contact_phone, "Contacts",
            "Tap the Card to add contacts"),
        //containerData(context, Icons.contact_page, "Professional Contacts",
        //    "Tap the Card to add contacts", 'ContactsP'),
        containerData(context, Icons.maps_home_work_outlined,"Making your Environment Safe",
            "Tap the Card to know how you can make Environment safe",'Environment'),
        containerData(context, Icons.wb_sunny, "Reasons to Live",
            "Tap the Card to add things that are worth for living", 'Reasons'),
        
        containerData(
            context,
            Icons.grid_on,
            "Other",
            "Tap the Card to add any additional notes that could helpful",
            'Notes'),
        //containerData(icon, title, subtitle)
      ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.greenAccent,
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
            label: 'Safety Plan',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'Reminders',
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            label: 'Resources',
            icon: Icon(Icons.book),
          ),
          BottomNavigationBarItem(
            label: 'Music',
            icon: Icon(Icons.music_note),
          ),
        ],
      ),
    );
  }
}
