import 'package:flutter/material.dart';

import 'firebase_handler.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with the actual number of messages
      itemBuilder: (context, index) {
        return MessageListItem(
          userName: 'Student Name $index',
          lastMessage: 'Last message from Student $index',
          messageThread: [], // Replace with the actual message thread
        );
      },
    );
  }
}

class MessageListItem extends StatelessWidget {
  final String userName;
  final String lastMessage;
  final List<String> messageThread;

  MessageListItem({
    required this.userName,
    required this.lastMessage,
    required this.messageThread,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(userName),
      subtitle: Text(lastMessage),
      children: messageThread
          .map((message) => ListTile(
                title: Text(userName),
                subtitle: Text(message),
              ))
          .toList(),
    );
  }
}

// class MessageList extends StatelessWidget {
//   final List<UserMessage> userMessages;
//
//   MessageList({required this.userMessages});
//
//   @override
//   Widget build(BuildContext context) {
//     // Implement your message list UI using the userMessages data.
//     // You can map the userMessages to widgets displaying user messages.
//     // Here's a simple example of how to display user messages in a ListView.
//
//     return ListView.builder(
//       itemCount: userMessages.length,
//       itemBuilder: (context, index) {
//         UserMessage message = userMessages[index];
//         return ListTile(
//           title: Text(message.userName ??
//               'No Name'), // Use a default value if userName is null
//           subtitle: Text(message.lastMessage ??
//               'No Message'), // Use a default value if lastMessage is null
//         );
//       },
//     );
//   }
// }
