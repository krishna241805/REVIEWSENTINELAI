import 'package:flutter/material.dart';
import 'package:flutter1/widget/app_bar.dart';
import 'package:flutter1/widget/infobox_help_widget.dart';

import 'generated/assets.dart';


class Help extends StatelessWidget {
  const Help({super.key});

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset('assets/images/background.jpeg',height: 300,width: double.infinity, fit: BoxFit.fill),

                Positioned(
                  top: 20,
                  left: 30,
                  right: 30,
                  bottom: 20,
                  child: Center(
                    child: Text(
                      'Hi. How Can We Help?',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoBox(
                  color: Colors.blueGrey,
                  title: 'Login',
                  content:
                      '1. Launch the Web on your device \n2. You’ll see the Login Page with fields for Email and Password. \n3. Use a valid email address (e.g., example@gmail.com) \n4. Enter Your Password must be at least 6 characters \n5. Tap the Login Button',
                ),
                InfoBox(
                  color: Colors.teal,
                  title: 'Register',
                  content:
                      '1. You’ll see the Register Page with fields for Email ,Password and confirm Password. \n2. Enter a new valid email address (e.g., you@gmail.com). \n3. Password Must be at least 6 characters. \n4. Re-enter the same password . \n5. Tap the Register Button',
                ),
                InfoBox(
                  color: Colors.lightBlueAccent,
                  title: 'Profile',
                  content:
                      '1. Enter First Name - Enter Last Name. \n2. Enter Email Address. \n3. Enter Contact Number. \n4. Enter Address. \n5. Enter City - Enter State. \n6. Enter Zip Code - Country. \n7. Enter valid Password. \n8. Tap on a Save Button.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
