import 'package:flutter/material.dart';

class BDescription extends StatefulWidget {
  final String busName;
  final String busColor;
  final int totalSeats;

  const BDescription({
    Key? key,
    required this.busName,
    required this.busColor,
    required this.totalSeats,
  }) : super(key: key);

  @override
  State<BDescription> createState() => _BDescriptionState();
}

class _BDescriptionState extends State<BDescription> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            const SizedBox(
              height: 80,
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/b_desc.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 100, top: 10, right: 10, bottom: 140),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/bus_icon.png',
                        width: 60,
                        height: 60,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Name: ${widget.busName}',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Color: ${widget.busColor}',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Total Seats: ${widget.totalSeats}',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _editBusData();
                            },
                            child: Text('Edit'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showDeleteConfirmationDialog(context);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editBusData() {
    // Implement the logic to edit bus data
    // For simplicity, we'll just print a message here
    print('Editing bus data: ${widget.busName}');
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Bus'),
          content: Text('Are you sure you want to delete ${widget.busName}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteBusData();
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteBusData() {
    // Implement the logic to delete bus data
    // For simplicity, we'll just print a message here
    print('Deleting bus data: ${widget.busName}');
  }
}
