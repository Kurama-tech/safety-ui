import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicModel {
  final String url;
  final String title;

  MusicModel(this.url, this.title);

  Map<String, dynamic> toMap() {
    return {'url': url, 'title': title};
  }
}

class MusicView extends StatefulWidget {
  const MusicView({key}) : super(key: key);

  _MusicView createState() => _MusicView();
}

class _MusicView extends State<MusicView> {
  List<MusicModel> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data.add(
        new MusicModel('https://youtu.be/SUVVvni4W6I', 'Meditation Music'));
    data.add(new MusicModel(
        'https://youtu.be/YCLnDcEP-1I', 'Relaxing nature sound'));
    data.add(
        new MusicModel('https://youtu.be/zPyg4N7bcHM', 'Calm Your Anxiety'));
    data.add(
        new MusicModel('https://youtu.be/79kpoGF8KWU', 'Relief from Stress'));
    data.add(
        new MusicModel('https://youtu.be/tEmt1Znux58', 'Relaxation technique'));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF6F8FC),
      appBar: AppBar(
        title: Text("Music"),
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
      body: Container(
        color: Color(0xFFF6F8FC),
        child: GridView.builder(
          padding: EdgeInsets.only(top: 12),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: InkWell(
                highlightColor: Colors.white,
                splashColor: Colors.grey,
                onTap: () async {
                  await launch(data[index].url);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Hero(
                          tag: data[index].url,
                          child: Icon(
                            Icons.music_note_sharp,
                            color: Color(0xFF3EB16F),
                            size: 50.0,
                          ),
                        ),
                        Hero(
                            tag: data[index].title,
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                data[index].title,
                                softWrap: true,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF3EB16F),
                                    fontWeight: FontWeight.w400),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.greenAccent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        selectedFontSize: 14,
        currentIndex: 3,
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
