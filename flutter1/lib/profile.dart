import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter1/widget/app_bar.dart';
import 'package:flutter1/upload_screen.dart';
import 'package:http/http.dart' as http;
import 'widget/textfield_profile_widget.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final zipcodeController = TextEditingController();
  final adressController = TextEditingController();
  final  numberController = TextEditingController();
  final cityController =  TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  // Profile Image
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child:
                          Image.asset('assets/images/1.jpg',height: 83,width: 83),
                          backgroundColor: Colors.white,
                          // foregroundImage: AssetImage('assets/images/login.jpeg'),
                          // foregroundImage: AssetImage('assets/images/7.jpeg'),
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   right: 0,
                        //   child: IconButton(
                        //     icon: const Icon(Icons.edit, color: Colors.brown),
                        //     onPressed: () {},
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Textfiled('First Name')),
                      SizedBox(width: 20),
                      Expanded(child: Textfiled('Last Name')),
                    ],
                  ),
                  SizedBox(height: 10),
                  Textfiled('Email'),
                  Textfiled('Contact Number'),
                  Textfiled('Address'),
                  Row(
                    children: [
                      Expanded(child: Textfiled('City')),
                      SizedBox(width: 20),
                      Expanded(child: Textfiled('State')),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: Textfiled('Zip Code')),
                      SizedBox(width: 20),
                      Expanded(child: Textfiled('Country')),
                    ],
                  ),
                  SizedBox(height: 10),
                  Textfiled(
                    'Password',
                    obscureText: !isPasswordVisible, // Toggle visibility
                    isPassword: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      setState(() {
                        save(
                          BuildContext,
                          context,
                          emailController ,
                          passController,
                          nameController,
                          numberController,
                          adressController,
                          cityController,
                          stateController,
                          countryController,
                          zipcodeController,
                        );
                      });

                      // if (_formKey.currentState!.validate()) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Profile Saved!')),
                      //   );
                      // }
                    },

                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> save(
    buildContext,
    context,
    dynamic emailController,
    dynamic passController,
    dynamic nameController,
    dynamic numberController,
    dynamic adressController,
    dynamic cityController,
    dynamic stateController,
    dynamic countryController,
    dynamic zipcodeController,
    ) async {
  var response = await http.post(
    Uri.parse('https://sathwarainfotech.com/developer/reviewsentinelai/update2.php'),
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "origin",
      "Access-Control-Allow-Credentials": "true",
    },
    body: jsonEncode({
      "first_name": nameController.text,
      "last_name": nameController.text,
      "email": emailController.text,
      "contact_number": numberController.text,
      "address": adressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "zip_code": zipcodeController.text,
      "country": countryController.text,
      "password": passController.text,
    }),
  );
  if (response.statusCode == 200) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UploadScreen()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.indigo,
        duration: Duration(seconds: 1),
        content: Text("Save Successfully"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
        showCloseIcon: true,
        dismissDirection: DismissDirection.horizontal,
        closeIconColor: Colors.white,
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.yellow),
            SizedBox(width: 18),
            Text("Something went wrong!"),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
