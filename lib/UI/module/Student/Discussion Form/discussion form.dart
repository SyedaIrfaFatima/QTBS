import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class QueryScreen extends StatefulWidget {
//   @override
//   _QueryScreenState createState() => _QueryScreenState();
// }
//
// class _QueryScreenState extends State<QueryScreen> {
//   final TextEditingController queryController = TextEditingController();
//   final List<QueryMessage> messages = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Discussion Forums'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(messages[index].message),
//                   subtitle: Text(messages[index].isUser ? 'User' : 'Manager'),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: queryController,
//                     decoration: InputDecoration(labelText: 'Your query'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     sendMessage(queryController.text, true);
//                     queryController.clear();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void sendMessage(String message, bool isUser) {
//     setState(() {
//       messages.add(QueryMessage(message, isUser));
//     });
//   }
// }
//
// class QueryMessage {
//   final String message;
//   final bool isUser;
//
//   QueryMessage(this.message, this.isUser);
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QueryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QueryScreen(),
    );
  }
}

class QueryScreen extends StatefulWidget {
  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  final TextEditingController queryController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _messagesCollection =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion Forums'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: _messagesCollection.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var messages = snapshot.data?.docs;
                List<Widget> messageWidgets = [];
                for (var message in messages!) {
                  final messageText = message['text'];
                  final isUser = message['isUser'];
                  messageWidgets.add(ListTile(
                    title: Text(messageText),
                    subtitle: Text(isUser ? 'User' : 'Manager'),
                  ));
                }
                return ListView(
                  children: messageWidgets,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: queryController,
                    decoration: InputDecoration(labelText: 'Your query'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(queryController.text, true);
                    queryController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String message, bool isUser) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      final String uid = user.uid;

      _messagesCollection.add({
        'text': message,
        'email': user.email,
        'isUser': isUser,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
}

// Future<List<UserMessage>> getUserMessages() async {
//   final QuerySnapshot messagesSnapshot =
//       await _firestore.collection('messages').get();
//
//   return messagesSnapshot.docs.map((doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return UserMessage(
//       userName: data['userName'],
//       lastMessage: data['lastMessage'],
//       messageThread: List<String>.from(data['messageThread']),
//     );
//   }).toList();
// }
