import 'package:flutter/material.dart';
import 'package:test_project/UI/widgets/round_button.dart';

class addpost extends StatefulWidget {
  const addpost({Key? key}) : super(key: key);

  @override
  State<addpost> createState() => _addpostState();
}

class _addpostState extends State<addpost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add post'),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Whats is in your mind bro',
                      border: OutlineInputBorder()),
                ),
                SizedBox(height: 30),
                RoundButton(title: "Add", onTap: () {})
              ],
            )));
  }
}
