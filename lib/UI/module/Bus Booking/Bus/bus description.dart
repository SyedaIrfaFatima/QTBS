import 'package:flutter/material.dart';

class bdescription extends StatelessWidget {
  const bdescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.blue,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Stack(children: [
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
        ])));
  }
}
