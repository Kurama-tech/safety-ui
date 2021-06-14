import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Appointments.dart';
import 'Medications.dart';

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
          indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 5.0)),
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
          labelColor: Theme.of(context).textTheme.headline4.color,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text("Crisis"),
            ),
            Tab(
              child: Text("For Veterans & Service Members"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            child: Card(
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              child: Column(children: [
                ListTile(
              //leading: Icon(Icons.label_important),
                  title: const Text('National Suicide Prevention Lifeline',style:TextStyle(fontSize: 20) ,),
                  subtitle: Text(
                    'If you are thinking about harming yourself, Please call the National Suicide Prevention Lifeline(Press 1 if you are a Veteran). The Lifeline is available 24/7 for free and confidential support ',
                   style: GoogleFonts.robotoSlab(fontSize: 15.0),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.cyan),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)))),
                    
                          
                  onPressed: () {
                    launch('tel:18002738255');
                  },
                  child: Text("Call National Suicide Prevention Lifeline"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.cyan),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)))),
                  onPressed: () {
                    launch('https://suicidepreventionlifeline.org/chat/');
                  },
                  child: Text("Chat with National Suicide Prevention Lifeline"),
                ),
                Card(
                  child: Column(children: [
                    ListTile(
                      //leading: Icon(Icons.label_important),
                      title: const Text('Crisis Text Line',style: TextStyle(fontSize: 20),),
                      subtitle: Text(
                        'To text with a Crisis Counselor, reach out to the Crisis Text Line. The Text line is free and available 24/7',
                        style: GoogleFonts.robotoSlab(fontSize: 15.0),
                      ),
                    ),
                    
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)))),
                      onPressed: () {
                        launch('https://www.crisistextline.org/');
                      },
                      child: Text("Criss Text line Website"),
                    ),
                  ]),
                ),
              ]),
            ),
          ),
           Container(
            child: Card(
              
              clipBehavior: Clip.antiAlias,
              child: Column(children: [
                ListTile(
                  //leading: Icon(Icons.label_important),
                  title: const Text('Find a VA Facility',style: TextStyle(fontSize: 20),),
                  subtitle: Text(
                    'The VA Offers a varierty of services including healthcare, counseling, and benefits. Click below to find your nearest VA location.',
                    style: GoogleFonts.robotoSlab(fontSize: 15.0),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.cyan),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)))),
                  onPressed: () {
                    launch('https://www.va.gov/');
                  },
                  child: Text("Find a VA"),
                ),
                
                Card(
                  
                  clipBehavior: Clip.antiAlias,
                  child: Column(children: [
                    ListTile(
                      //leading: Icon(Icons.label_important),
                      title: const Text('Vet Centers',style: TextStyle(fontSize: 20),),
                      subtitle: Text(
                        'VetCenters also have care for Veterans, and continue to serve Veterans during any situation',
                        style: GoogleFonts.robotoSlab(fontSize: 15.0),
                      ),
                    ),
                    
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)))),
                      onPressed: () {
                        launch('https://www.va.gov/find-locations');
                      },
                      child: Text("Find a VET Center"),
                    ),
                  ]),
                ),
              ]),
            ),
          ),
          
        ],
      ),
    );
  }
}
