import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class mfeedback extends StatefulWidget {
  @override
  _mfeedbackState createState() => _mfeedbackState();
}

class _mfeedbackState extends State<mfeedback> {
  late Future<List<Feedback>> feedbackList;

  Future<List<Feedback>> fetchFeedback() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('feedback').get();

    final feedbackList = snapshot.docs.map((doc) {
      return Feedback(
        email: doc.get('email') ?? 'N/A',
        comment: doc.get('comment') ?? 'N/A',
        rating: doc.get('rating') ?? 0,
      );
    }).toList();

    return feedbackList;
  }

  @override
  void initState() {
    super.initState();
    feedbackList = fetchFeedback();
  }

  // DataTable buildFeedbackTable(List<Feedback> feedbackList) {
  //   return DataTable(
  //     columns: [
  //       DataColumn(label: Text('Comment')),
  //       DataColumn(label: Text('Email')),
  //       DataColumn(label: Text('Rating')),
  //     ],
  //     rows: feedbackList.map((feedback) {
  //       return DataRow(
  //         cells: [
  //           DataCell(Text(feedback.comment)),
  //           DataCell(Text(feedback.email)),
  //           DataCell(Text(feedback.rating.toString())),
  //         ],
  //       );
  //     }).toList(),
  //   );
  // }

  DataTable buildFeedbackTable(List<Feedback> feedbackList) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Comment')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Rating')),
      ],
      rows: feedbackList.map((feedback) {
        return DataRow(
          cells: [
            DataCell(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(feedback.comment),
                ],
              ),
            ),
            DataCell(Text(feedback.email)),
            DataCell(Text(feedback.rating.toString())),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedback')),
      body: FutureBuilder<List<Feedback>>(
        future: feedbackList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              child: buildFeedbackTable(snapshot.data!),
            );
          }
        },
      ),
    );
  }
}

class Feedback {
  final String comment;
  final String email;
  final double rating;

  Feedback({
    required this.comment,
    required this.email,
    required this.rating,
  });
}
