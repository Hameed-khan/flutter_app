import 'package:SmartCal/history.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
void main()=>runApp(MaterialApp(
  home: myapp(),
));
class myapp extends StatelessWidget {
  final _ref = FirebaseDatabase.instance.reference().child('recordSmartCal');
  Widget _buildContactItem({Map contact})
  {
    return Scrollbar(child: Column(
      children: [
        Container(
          height: 60.0,
          width: 600.0,
          decoration: BoxDecoration(
            color: Colors.grey[100],

          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5,10,0,0),
            child: Text('Equestion:    '+
                contact['equestion'],style: TextStyle(fontSize: 30,),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 60.0,
          width: 600.0,
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),

          child: Padding(
            padding: const EdgeInsets.fromLTRB(5,10,0,0),
            child: Text('Result:            '+
                contact['solution'],style: TextStyle(fontSize: 30,)
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    ),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetching Data"),
      ),
    body:  Container(
      height: double.infinity,
      child: FirebaseAnimatedList(
        query: _ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map contact = snapshot.value;

          return _buildContactItem(contact: contact);
        },
      ),
    ),
    //   body: FirebaseAnimatedList(query: _ref,
    // itemBuilder: (BuildContext context, DataSnapshot snapshot,
    // Animation<double> animation, int index));
    );

  }
}
