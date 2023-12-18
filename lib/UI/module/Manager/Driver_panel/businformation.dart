import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class BusInformationPage extends StatefulWidget {
//   @override
//   State<BusInformationPage> createState() => _BusInformationPageState();
// }
//
// class _BusInformationPageState extends State<BusInformationPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:
//             Text('Bus Information', style: GoogleFonts.poppins(fontSize: 20)),
//         centerTitle: true,
//         // leading: IconButton(
//         //   onPressed: () => Navigator.pop(context),
//         //   icon:,
//         // ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/reg manager.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(16),
//                 child: Text('Bus Information',
//                     style: GoogleFonts.poppins(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//               ),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     Card(
//                       child: ListTile(
//                         title: Text('Islamabad Expressway-Kasmir Highway'),
//                         subtitle: Text('6:20 am-12:00pm'),
//                         leading: CircleAvatar(
//                           child: Icon(Icons.person),
//                         ),
//                         trailing: Text('Rizwan Ahmed'),
//                       ),
//                     ),
//                     Card(
//                       child: ListTile(
//                         title: Text('Islamabad Expressway-Kasmir Highway'),
//                         subtitle: Text('8:30 am-2:00pm'),
//                         leading: CircleAvatar(
//                           child: Icon(Icons.person),
//                         ),
//                         trailing: Text('Shafiq Khan'),
//                       ),
//                     ),
//                     Card(
//                       child: ListTile(
//                         title: Text('Islamabad Expressway-Kasmir Highway'),
//                         subtitle: Text('10:00 am-4:10pm'),
//                         leading: CircleAvatar(
//                           child: Icon(Icons.person),
//                         ),
//                         trailing: Text('Rana Waqas'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class BusInformationPage extends StatefulWidget {
  @override
  State<BusInformationPage> createState() => _BusInformationPageState();
}

// class _BusInformationPageState extends State<BusInformationPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bus Information',
//             style:
//                 GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           // Replace the background image with a solid color
//           Container(
//             color: Colors.grey[200],
//           ),
//           Center(
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   child: Text('Bus Information',
//                       style: GoogleFonts.poppins(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black)),
//                 ),
//                 Expanded(
//                   child: ListView.separated(
//                     padding: EdgeInsets.all(16),
//                     itemCount: 3,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Icon(Icons.bus_alert_rounded),
//                             backgroundColor: Colors.blue[300],
//                             foregroundColor: Colors.white,
//                           ),
//                           title: Text(
//                             'Islamabad Expressway-Kasmir Highway',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           ),
//                           subtitle: Text(
//                             '6:20 am-12:00pm',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14, color: Colors.grey),
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.edit),
//                                 onPressed: () {},
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.delete),
//                                 onPressed: () {},
//                                 color: Colors.grey,
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) => SizedBox(height: 16),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _BusInformationPageState extends State<BusInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Information',
            style: GoogleFonts.poppins(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Stack(
        children: [
          // Replace the background image with a solid color
          Container(
            color: Colors.grey[200],
          ),
          Center(
            child: Container(
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text('Bus Information',
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(16),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.person),
                              backgroundColor: Colors.blue[300],
                              foregroundColor: Colors.white,
                            ),
                            title: Text(
                              'Islamabad Expressway-Kasmir Highway',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Driver: Rizwan Ahmed',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Text(
                                  '6:20 am-12:00pm',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {},
                                  color: Colors.redAccent,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
