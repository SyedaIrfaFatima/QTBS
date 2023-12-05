import 'package:flutter/material.dart';

class Studentsapid extends StatefulWidget {
  const Studentsapid({Key? key}) : super(key: key);

  @override
  State<Studentsapid> createState() => _StudentsapidState();
}

class _StudentsapidState extends State<Studentsapid> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Sap Id',
                ),
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Submit the form.
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
