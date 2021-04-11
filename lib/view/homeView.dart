import 'dart:developer';
import 'package:safety/provider/counter.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:safety/view/counterView.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({key}) : super(key: key);
  static const title = "Safety";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        title: 
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body:ListView(
        children: [
          InkWell(
            child:Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    
                    title: const Text('Safety Plan'),
                    subtitle: Text(
                      'Tap ',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
               
                  Image.asset(
                                        "images/4070-ai.png",
                                        width: 400,
                                        height: 200,
                                        fit:BoxFit.fill  

                                      )
                  
                ],
                
              ),
            ),
             onTap: () { 
        print("Click event on Container"); 
    },
          ),
          
        InkWell(
            child:Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    
                    title: const Text('Reminder'),
                    subtitle: Text(
                      'Secondary Text',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  
                  
                  Image.asset(
                                        "images/13269-ai.png",
                                        width: 400,
                                        height: 200,
                                        fit:BoxFit.fill  

                                      )
                ],
              ),
            ),
                     onTap: () { 
        print("Click event on Container"); 
    },
        ),

            
              InkWell(
            child:Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    
                    title: const Text('Resources'),
                    subtitle: Text(
                      'Secondary Text',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                 
                  
                   Image.asset(
                                        "images/resources.png",
                                        width: 400,
                                        height: 200,
                                        fit:BoxFit.fill  

                                      )
                  //Image.asset("images/8441-ai.png"),
                ],
              ),
            ),
                     onTap: () { 
        print("Click event on Container"); 
    },
              ),


          InkWell(
            child:Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    
                    title: const Text('Music'),
                    subtitle: Text(
                      'Secondary Text',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  
                  Image.asset(
                                        "images/5870-ai.png",
                                        width: 400,
                                        height: 200,
                                        fit:BoxFit.fill  

                                      )
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
      )
    );
  }
}
