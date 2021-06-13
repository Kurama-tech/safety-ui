import 'package:flutter/material.dart';
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
                  leading: Icon(Icons.videocam,size: 40,),
                  title: Text(
                    " RELAXING nature sound ",
                    style: GoogleFonts.robotoSlab(fontSize: 15.0),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
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
                  leading: Icon(Icons.videocam,size: 40,),
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
                  leading: Icon(Icons.videocam,size: 40,),
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
                  leading: Icon(Icons.videocam,size: 40,),
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
      
    );
  }
}
