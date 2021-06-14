import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';



class Resources extends StatefulWidget {
  const Resources({key}) : super(key: key);

  @override
  _ResourcesState createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(width: 2, color: Colors.white)),
        bottom: TabBar(
          indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 4.0)),
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
          labelColor: Theme.of(context).textTheme.headline3.color,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text("Crisis"),
            ),
            Tab(
              child: Text("For Veterans"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          SingleChildScrollView(
            child:Column(children: [
                ListTile(
                  //leading: Icon(Icons.label_important),
                  title: const Text(
                    'National Suicide Prevention Lifeline',
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    'If you are thinking about harming yourself, Please call the National Suicide Prevention Lifeline(Press 1 if you are a Veteran). The Lifeline is available 24/7 for free and confidential support ',
                    style: GoogleFonts.robotoSlab(fontSize: 15.0),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.cyan),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)))),
                  onPressed: () {
                    launch('tel:18002738255');
                  },
                  child: Text("Call National Suicide Prevention Lifeline"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.cyan),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)))),
                  onPressed: () {
                    launch('https://suicidepreventionlifeline.org/chat/');
                  },
                  child: Text("Chat with National Suicide Prevention Lifeline"),
                ),
                Divider(),
                
                 Column(children: [
                    ListTile(
                      //leading: Icon(Icons.label_important),
                      title: const Text(
                        'Crisis Text Line',
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        'To text with a Crisis Counselor, reach out to the Crisis Text Line. The Text line is free and available 24/7',
                        style: GoogleFonts.robotoSlab(fontSize: 15.0),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18)))),
                      onPressed: () {
                        launch('https://www.crisistextline.org/');
                      },
                      child: Text("Criss Text line Website"),
                    ),
                  ]),
                  Divider(),
                 Column(children: [
                    ListTile(
                      //leading: Icon(Icons.label_important),
                      title: const Text(
                        "SAMHSA's Helpline",
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        "SAMHSA's National Helpline is a free confidential information and referral servide that is available 24/7 for individuals for families facing mental halth or substance use problems.",
                        style: GoogleFonts.robotoSlab(fontSize: 15.0),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18)))),
                      onPressed: () {
                        launch('18006624357');
                      },
                      child: Text("Call SAMHSA's Helpline"),
                    ),
                  ]),
                
              ]),
          ),
            
          
          
          
          SingleChildScrollView(
            child: Column(children: [
                ListTile(
                  //leading: Icon(Icons.label_important),
                  title: const Text(
                    'Find a VA Facility',
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    'The VA Offers a varierty of services including healthcare, counseling, and benefits. Click below to find your nearest VA location.',
                    style: GoogleFonts.robotoSlab(fontSize: 15.0),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.cyan),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)))),
                  onPressed: () {
                    launch('https://www.va.gov/');
                  },
                  child: Text("Find a VA"),
                ),
                Divider(),
                 Column(children: [
                    ListTile(
                      //leading: Icon(Icons.label_important),
                      title: const Text(
                        'Vet Centers',
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        'VetCenters also have care for Veterans, and continue to serve Veterans during any situation',
                        style: GoogleFonts.robotoSlab(fontSize: 15.0),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18)))),
                      onPressed: () {
                        launch('https://www.va.gov/find-locations');
                      },
                      child: Text("Find a VET Center"),
                    ),
                  ]),
                Divider(),
                 Column(children: [
                    ListTile(
                      //leading: Icon(Icons.label_important),
                      title: const Text(
                        'VA Caregiver Support',
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        "Find your VA's Caregiver Support Coordinator",
                        style: GoogleFonts.robotoSlab(fontSize: 15.0),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18)))),
                      onPressed: () {
                        launch('h18552603274');
                      },
                      child: Text("Call VA Caregiver Support Line"),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18)))),
                      onPressed: () {
                        launch('https://www.caregiver.va.gov/');
                      },
                      child: Text("Visit VA Caregiver Support website"),
                    ),
                  ]),
                Divider(),
                 Column(children: [
                    ListTile(
                      //leading: Icon(Icons.label_important),
                      title: const Text(
                        'Women Veterans',
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        'Women Veterans and their families can access a wide range of information and resources through the Center for Women Veterans(CWV), or can call or text the Women Veterans Call Center(WVCC)',
                        style: GoogleFonts.robotoSlab(fontSize: 15.0),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18)))),
                      onPressed: () {
                        launch('https://www.va.gov/womenvet/');
                      },
                      child: Text("Call Wvcc"),
                    ),
                  ]),
                
              ]),
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
