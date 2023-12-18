import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

// class mfeedback extends StatefulWidget {
//   @override
//   _mfeedbackState createState() => _mfeedbackState();
// }
//
// class _mfeedbackState extends State<mfeedback> {
//   late Future<List<Feedback>> feedbackList;
//
//   Future<List<Feedback>> fetchFeedback() async {
//     final QuerySnapshot<Map<String, dynamic>> snapshot =
//         await FirebaseFirestore.instance.collection('feedback').get();
//
//     final feedbackList = snapshot.docs.map((doc) {
//       return Feedback(
//         email: doc.get('email') ?? 'N/A',
//         comment: doc.get('comment') ?? 'N/A',
//         rating: doc.get('rating') ?? 0,
//       );
//     }).toList();
//
//     return feedbackList;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     feedbackList = fetchFeedback();
//   }
//
//   DataTable buildFeedbackTable(List<Feedback> feedbackList) {
//     return DataTable(
//       columns: [
//         DataColumn(label: Text('Comment')),
//         DataColumn(label: Text('Email')),
//         DataColumn(label: Text('Rating')),
//       ],
//       rows: feedbackList.map((feedback) {
//         return DataRow(
//           cells: [
//             DataCell(
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(feedback.comment),
//                 ],
//               ),
//             ),
//             DataCell(Text(feedback.email)),
//             DataCell(Text(feedback.rating.toString())),
//           ],
//         );
//       }).toList(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('Feedback',
//               style: GoogleFonts.poppins(
//                   fontSize: 20,
//                   // fontWeight: FontWeight.bold,
//                   color: Colors.white))),
//       body: FutureBuilder<List<Feedback>>(
//         future: feedbackList,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return SingleChildScrollView(
//               child: buildFeedbackTable(snapshot.data!),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
// class Feedback {
//   final String comment;
//   final String email;
//   final double rating;
//
//   Feedback({
//     required this.comment,
//     required this.email,
//     required this.rating,
//   });
// }

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
        rating: doc.get('rating') ?? 0.toDouble(),
      );
    }).toList();

    return feedbackList;
  }

  @override
  void initState() {
    super.initState();
    feedbackList = fetchFeedback();
  }

  // Widget buildFeedbackCards(List<Feedback> feedbackList) {
  //   return ListView.builder(
  //     itemCount: feedbackList.length,
  //     itemBuilder: (context, index) {
  //       Feedback feedback = feedbackList[index];
  //       return Card(
  //         margin: EdgeInsets.all(8.0),
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 'Email: ${feedback.email}',
  //                 style: TextStyle(fontWeight: FontWeight.bold),
  //               ),
  //               SizedBox(height: 8.0),
  //               Text(
  //                 'Comment: ${feedback.comment}',
  //                 style: TextStyle(fontWeight: FontWeight.bold),
  //               ),
  //               SizedBox(height: 8.0),
  //               Text(
  //                 'Rating: ${feedback.rating.toString()}',
  //                 style: TextStyle(fontWeight: FontWeight.bold),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget buildFeedbackCards(List<Feedback> feedbackList) {
    return ListView.builder(
      itemCount: feedbackList.length,
      itemBuilder: (context, index) {
        Feedback feedback = feedbackList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email:', // Remove `${feedback.email}`
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  feedback.email, // Add feedback.email here
                ),
                SizedBox(height: 8.0),
                Text(
                  'Comment:', // Remove `${feedback.comment}`
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  feedback.comment, // Add feedback.comment here
                ),
                SizedBox(height: 8.0),
                Text(
                  'Rating:', // Remove `${feedback.rating.toString()}`
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  feedback.rating
                      .toString(), // Add feedback.rating.toString() here
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback',
          // ... (other styling remains unchanged)
        ),
      ),
      body: FutureBuilder<List<Feedback>>(
        future: feedbackList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return buildFeedbackCards(snapshot.data!);
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
