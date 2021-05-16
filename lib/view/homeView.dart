import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:safety/view/remindersView.dart';
import 'package:safety/view/resourcesView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:safety/view/safetyPlanView.dart';
// ignore: unused_import
import 'package:cupertino_icons/cupertino_icons.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({key}) : super(key: key);
  static const title = "Safety";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(width: 2, color: Colors.white)),
          leading: Icon(
            Icons.local_hospital_rounded,
            color: Colors.black,
          ),
          centerTitle: true,
          titleSpacing: 7.0,
          title: Container(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          elevation: 3.0,
          systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.greenAccent,
              systemNavigationBarIconBrightness: Brightness.dark),
        ),
        extendBodyBehindAppBar: false,
        floatingActionButton: buildSpeedDial(),
        backgroundColor: Colors.grey.shade200,
        body: ListView(
          children: [
            InkWell(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'Safety Plan',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      subtitle: Text(
                        'Create or Edit your Safety plan.',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    new Image.asset("assets/images/4070-ai.png",
                        width: 400, height: 200, fit: BoxFit.fill)
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SafetyPlan(),
                  ),
                );
              },
            ),
            InkWell(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'Reminder',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      subtitle: Text(
                        'Manage your Medications and Appointments through Remainders.',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Image.asset("assets/images/13269-ai.png",
                        width: 400, height: 200, fit: BoxFit.fill)
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Reminders(),
                  ),
                );
              },
            ),
            InkWell(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'Resources',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      subtitle: Text(
                        'Browse through different Resources.',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),

                    Image.asset("assets/images/resources.png",
                        width: 400, height: 200, fit: BoxFit.fill)
                    //Image.asset("images/8441-ai.png"),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Resources(),
                  ),
                );
               
              },
            ),
            InkWell(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'Music',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      subtitle: Text(
                        'Feeling Low! How about some Music or Podcasts.',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    new Image.asset("assets/images/5870-ai.png",
                        width: 400, height: 200, fit: BoxFit.fill)
                  ],
                ),
              ),
              onTap: () {
                print("Click event on Container");
              },
            ),

            /* Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('You have pushed the button this many times:'),

            /// Extracted as a separate widget for performance optimization.
            /// As a separate widget, it will rebuild independently from [MyHomePage].
            ///
            /// This is totally optional (and rarely needed).
            /// Similarly, we could also use [Consumer] or [Selector].
            Count(), //https://github.com/Kurama-tech/safety-ui.git
          ],
        ),
      ),  */

/* 
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),

        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.
        onPressed: () => context.read<Counter>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add), */
          ],
        ));
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      /// both default to 16
      marginEnd: 19,
      marginBottom: 21,
      //animatedIcon: AnimatedIcons.play_pause,
      // animatedIconTheme: IconThemeData(size: 22.0),
      /// This is ignored if animatedIcon is non null
      icon: CupertinoIcons.exclamationmark_octagon,
      activeIcon: Icons.close,
      iconTheme: IconThemeData(color: Colors.red, size: 40),

      /// The label of the main button.
      //label: Text(""),
      /// The active label of the main button, Defaults to label if not specified.
      //activeLabel: Text("Crisis Menu"),
      /// Transition Builder between label and activeLabel, defaults to FadeTransition.
      // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
      /// The below button size defaults to 56 itself, its the FAB size + It also affects relative padding and other elements
      buttonSize: 66.0,
      visible: true,

      /// If true user is forced to close dial manually
      /// by tapping main button and overlay is not rendered.
      closeManually: false,
      curve: Curves.easeInOutCirc,
      overlayColor: Colors.black87,
      overlayOpacity: 0.7,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Crisis Menu ',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.white,
      foregroundColor: Colors.red,
      elevation: 9.0,
      shape: CircleBorder(),

      //orientation: SpeedDialOrientation.Down,
      // childMarginBottom: 2,R
      // childMarginTop: 2,
      gradientBoxShape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.greenAccent, Colors.orangeAccent],
      ),
      children: [
        SpeedDialChild(
          child: Icon(Icons.call),
          backgroundColor: Colors.redAccent,
          label: 'Call 911',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => launch("tel:911"),
          onLongPress: () => print('FIRST CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(
            Icons.phone,
            color: Colors.red,
          ),
          backgroundColor: Colors.orangeAccent,
          label: 'Call Helpline',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            launch('tel:8123303633');
          },
          onLongPress: () => print('SECOND CHILD LONG PRESS'),
        ),
      ],
    );
  }
}
