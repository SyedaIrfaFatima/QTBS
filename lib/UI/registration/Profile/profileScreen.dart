import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:test_project/Authentication/models/User_model.dart';
import 'package:test_project/Constants/Test%20String.dart';
import 'package:test_project/UI/registration/Profile/profile_controller.dart';

import '../../widgets/round_button.dart';
import '../../Module/HomeScreen/Homee.dart';

void main() {
  runApp(const profile());
}

class profile extends StatelessWidget {
  const profile({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edit Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EditProfile(),
    );
  }
}

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          title: Text('Edit Profile'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Container(
                child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data as UserModel;

                    final fullname = TextEditingController(text: user.fullName);
                    final email = TextEditingController(text: user.email);
                    final sapid = TextEditingController(text: user.Sapid);
                    final address = TextEditingController(text: user.Address);
                    final phoneno = TextEditingController(text: user.phoneNo);
                    final password = TextEditingController(text: user.Password);
                    final confirmpassword =
                        TextEditingController(text: user.ConfirmPassword);

                    return SingleChildScrollView(
                        child: Column(children: [
                      Center(
                          child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/profileimage.jpg'),
                              ),
                            ),
                          ),
                        ],
                      )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 100, right: 10, bottom: 0),
                          child: SingleChildScrollView(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  TextFormField(
                                    controller: fullname,
                                    // initialValue: userdata.fullName,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        hintText: 'Full name ',
                                        suffixIcon: Icon(Icons.person)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: email,
                                    // initialValue: userdata.email,
                                    keyboardType: TextInputType.emailAddress,
                                    // controller: emailController,
                                    decoration: const InputDecoration(
                                        hintText: 'Email',
                                        suffixIcon: Icon(Icons.edit)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: phoneno,
                                    // initialValue: userdata.phoneNo,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: 'phone no',
                                        suffixIcon: Icon(Icons.edit)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: sapid,
                                    // initialValue: userdata.Sapid,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: 'Sap Id',
                                        suffixIcon: Icon(Icons.numbers)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: address,
                                    // initialValue: userdata.Address,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: 'Address',
                                        suffixIcon: Icon(Icons.edit)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: password,
                                    // initialValue: userdata.Password,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        hintText: 'password',
                                        suffixIcon: Icon(Icons.edit)),
                                  ),
                                ],
                              ),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final updatedUserData = UserModel(
                                      Sapid: sapid.text.trim(),
                                      fullName: fullname.text.trim(),
                                      email: email.text.trim(),
                                      phoneNo: phoneno.text.trim(),
                                      Address: address.text.trim(),
                                      Password: password.text.trim(),
                                      ConfirmPassword:
                                          confirmpassword.text.trim(),
                                    );

                                    await controller.updateRecord(user);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      side: BorderSide.none,
                                      shape: const StadiumBorder()),
                                  child: const Text(ieditprofile,
                                      style: TextStyle(
                                          color: Colors.indigoAccent)),
                                ),
                              ),

                              // Optionally, you can navigate to another page after saving.
                              // For example, navigate to the Home screen after saving:

                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: Colors.indigoAccent,
                              //     side: BorderSide.none,
                              //   ),
                              //   child: const Text("Save"),
                              // )

                              // RoundButton(
                              //     title: 'Save',
                              //     // loading: loading,
                              //     onTap: ()=> Get.to(() => profile()) async {
                              //       final userData = UserModel(
                              //         Sapid: sapid.text.trim(),
                              //         fullName: fullname.text.trim(),
                              //         email: email.text.trim(),
                              //         phoneNo: phoneno.text.trim(),
                              //         Address: address.text.trim(),
                              //         Password: password.text.trim(),
                              //         ConfirmPassword: password.text.trim(),
                              //       );
                              //
                              //       await controller.updateRecord(userdata);
                              //
                              //       // Corrected the line here
                              //     }
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => LoginScreen()));
                              // },
                              // ),
                            ],
                          )))
                    ]));
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(child: Text('Something went wrong'));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ))));
  }
}
