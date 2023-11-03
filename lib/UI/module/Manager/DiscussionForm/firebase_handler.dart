import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserMessage>> fetchUserMessages() async {
    final QuerySnapshot messagesSnapshot =
        await _firestore.collection('messages').get();

    return messagesSnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return UserMessage(
        userName: data['userName'],
        lastMessage: data['lastMessage'],
        messageThread: List<String>.from(data['messageThread']),
      );
    }).toList();
  }

  Future<void> addUserMessage(UserMessage message) async {
    await _firestore.collection('messages').add({
      'userName': message.userName,
      'lastMessage': message.lastMessage,
      'messageThread': message.messageThread,
    });
  }
}

class UserMessage {
  final String userName;
  final String lastMessage;
  final List<String> messageThread;

  UserMessage({
    required this.userName,
    required this.lastMessage,
    required this.messageThread,
  });
}
