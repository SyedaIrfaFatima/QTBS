import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/Authentication/login_with_phonenumber.dart';
import 'package:test_project/UI/Module/HomeScreen/Homee.dart';
import 'package:test_project/UI/registration/Util/utils.dart';
import 'package:test_project/UI/registration/forgetpassword.dart';
import 'package:test_project/UI/registration/registration.dart';
import 'package:test_project/UI/registration/resetpassword.dart';
import 'package:test_project/posts/post_Screen.dart';

import '../widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      utils().toastMessage(value.user!.email.toString());

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Login',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgroundd.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                suffixIcon: Icon(Icons.alternate_email)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter email';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: 'password',
                                suffixIcon: Icon(Icons.lock_open)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter password';
                              }
                              return null;
                            }),
                      ],
                    )),
                // Padding(
                //   padding: const EdgeInsets.only(left: 180),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       TextButton(
                //         onPressed: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => ResetPassword(),
                //             ),
                //           );
                //         },
                //         child: Text("Forget password"),
                //       ),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 40,
                ),
                RoundButton(
                  title: 'Login',
                  loading: loading,
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      login();
                    }
                  },
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => forgetpassword()));
                      },
                      child: Text("Forgot password")),
                ),
                const SizedBox(
                  height: 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => register()));
                        },
                        child: Text("Sign up"))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => loginWithphonenumber()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.black,
                          )),
                      child: Center(
                        child: Text('Login with phone'),
                      ),
                    ))
              ]),
        )
      ]),
    );
  }
}
