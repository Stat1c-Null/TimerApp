import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(TimerApp());
}

//Create a stateful widget, meaning it's state will be changing
class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

//Create State and Initialize Variables
class _TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);

  // ignore: non_constant_identifier_names
  int seconds_passed = 0;
  bool active = false;

  Timer timer;

  // ignore: non_constant_identifier_names
  void handle_tick(){ //Start counting seconds
    if(active){
      setState(() {
        seconds_passed = seconds_passed + 1;
      });
    }
  }
  //Timer Widget Itself
  @override
  Widget build(BuildContext context) {
    if(timer == null){
      timer = Timer.periodic(duration, (Timer t) {
        handle_tick();
      });
    }
    //Convert seconds into minutes and minutes into hours
    int seconds = seconds_passed % 60;
    int minutes = seconds_passed ~/ 60;
    int hours = seconds_passed ~/ (60*60);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple[200], // CHANGE entire application BACKGROUND COLOR HERE
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[600],
          title: Center(child: Text('Timer'),
          ),
        ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LabelText(// Set Hours on the screen
                  label: 'Hours', value: hours.toString().padLeft(2, '0')
                ),
                LabelText(// Set Minutes on the screen
                    label: 'Minutes', value: minutes.toString().padLeft(2, '0')
                ),
                LabelText(// Set Seconds on the screen
                    label: 'Seconds', value: seconds.toString().padLeft(2, '0')
                ),
              ],
            ),
            SizedBox(height: 60),
            Container(// Create a Start Stop Button
              width: 80,
              height: 47,
              margin: EdgeInsets.only(top: 30),
              child: RaisedButton(
                color: Colors.purpleAccent[400],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                child: Text(active ? 'Stop' : 'Start'), // If timer is off, button will show start, otherwise stop
                onPressed: (){
                  setState(() {
                    active = !active; // On Press, change Active variable from False to True and otherwise
                  });
                },
              ),
            ),
            Container(// Create a Reset Button
              width: 80,
              height: 47,
              margin: EdgeInsets.only(top: 10),
              child: RaisedButton(
                color: Colors.purpleAccent[400],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                child: Text("Reset"),
                onPressed: (){
                  setState(() {
                    active = false;
                    seconds_passed = 0;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
// Create a stateless text widget meaning it's state wont ever change
class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Colors.deepPurpleAccent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 45,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
                color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}



