import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Music extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      appBar: AppBar(
        title: Text("Music"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(width: 2, color: Colors.white)),
      ),
      body: ListView(
        children: [
          Container(
         padding: EdgeInsets.fromLTRB(10,10,10,0),
                    height: 100,
                    width: double.maxFinite,
          child: InkWell(
            child: Card(
              elevation: 5,
              child: Center(
                child: ListTile(
                  leading: Icon(Icons.videocam,size: 40,),
                  title: Text(
                    "Meditation Music",
                    style: GoogleFonts.robotoSlab(fontSize: 15.0),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () async {
                    const url = 'https://youtu.be/SUVVvni4W6I';
                    await canLaunch(url)
                        ? await launch(url)
                        : throw 'Could not launch $url';
                  },
                ),
              ),
            ),
          ),),
          Container(
         padding: EdgeInsets.fromLTRB(10,10,10,0),
                    height: 100,
                    width: double.maxFinite,
          child: InkWell(
            child: Card(
              elevation: 5,
              child: Center(
                child: ListTile(
                  leading: Icon(Icons.music_note,size: 40,color: Color(0xFF3EB16F),),
                  title: Text(
                    " RELAXING nature sound ",
                    style: GoogleFonts.robotoSlab(fontSize: 15.0,color: Color(0xFF3EB16F))
                    ,
                  ),
                  
                  trailing: Icon(Icons.play_arrow,color: Color(0xFF3EB16F),),
                  onTap: () async {
                    const url = 'https://youtu.be/YCLnDcEP-1I';
                    await canLaunch(url)
                        ? await launch(url)
                        : throw 'Could not launch $url';
                  },
                ),
              ),
            ),
          ),
          ),
          Container(
         padding: EdgeInsets.fromLTRB(10,10,10,0),
                    height: 100,
                    width: double.maxFinite,
          child: InkWell(
            child: Card(
              elevation: 5,
              child: Center(
                child: ListTile(
                  leading: Icon(Icons.music_note,size: 40,),
                  title: Text(
                    "Calm Your Anxiety",
                    style: GoogleFonts.robotoSlab(fontSize: 15.0),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () async {
                    const url = 'https://youtu.be/zPyg4N7bcHM';
                    await canLaunch(url)
                        ? await launch(url)
                        : throw 'Could not launch $url';
                  },
                ),
              ),
            ),
          ),
          ),
         Container(
         padding: EdgeInsets.fromLTRB(10,10,10,0),
                    height: 100,
                    width: double.maxFinite,
          child: InkWell(
            child: Card(
              elevation: 5,
              child: Center(
                child: ListTile(
                  leading: Icon(Icons.music_note,size: 40,),
                  title: Text(
                    "Instant Relief from Stress and Anxiety ",
                    style: GoogleFonts.robotoSlab(fontSize: 15.0),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () async {
                    const url = 'https://youtu.be/79kpoGF8KWU';
                    await canLaunch(url)
                        ? await launch(url)
                        : throw 'Could not launch $url';
                  },
                ),
              ),
            ),
          ),
         ),
          Container(
         padding: EdgeInsets.fromLTRB(10,10,10,0),
                    height: 100,
                    width: double.maxFinite,
          child: InkWell(
            child: Card(
              elevation: 5,
              child: Center(
                child: ListTile(
                  leading: Icon(Icons.music_note,size: 40,),
                  title: Text(
                    "Box breathing relaxation technique",
                    style: GoogleFonts.robotoSlab(fontSize: 15.0),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () async {
                    const url = 'https://youtu.be/tEmt1Znux58';
                    await canLaunch(url)
                        ? await launch(url)
                        : throw 'Could not launch $url';
                  },
                ),
              ),
            ),
          ),
          ),
        ],
      ),
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
