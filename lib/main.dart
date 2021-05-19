import 'package:flutter/material.dart';
import './Calculator.dart';
import './history.dart';
import './voiceInput.dart';
import './voiceHistory.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(

            title: TabBar(
              tabs: [
                Text("Calculator"),
                Text("History"),
                Text("VoiceI"),
                Text("VoiceH")

              ],
            ),
          ),
          body: TabBarView(
            children: [
              MyCalcutor(),
              calHistory(),
              MApp(),
              History(),
            ],
          ),
        ),
      ),
    );
  }
}

