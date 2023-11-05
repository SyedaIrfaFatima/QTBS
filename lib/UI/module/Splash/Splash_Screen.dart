import 'package:flutter/material.dart';
import 'package:test_project/Firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices(selectRoute: '');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          // Wrap with Container
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgroundd.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Center(
          child: Image(
            height: 700,
            width: 600,
            image: AssetImage('assets/splash logo.png'),
          ),
        ),
      ],
    ));
  }
}
