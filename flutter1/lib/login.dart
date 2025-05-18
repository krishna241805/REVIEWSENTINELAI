import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter1/widget/app_bar.dart';
import 'package:flutter1/upload_screen.dart';
import 'package:flutter1/widget/textfield_profile_widget.dart';
import 'package:http/http.dart' as http; // Adjust this path as needed



class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  LoginpageState createState() => LoginpageState();
}

class LoginpageState extends State<Loginpage>
    with SingleTickerProviderStateMixin {
  late bool isObscure = true;
  late bool isPasswordVisible = false;
  late bool isConfirmPasswordVisible = true;
  late TabController tabController;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();


  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sign In to\nMy Application',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "If you don't have an account",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You can',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 15),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register Here!',
                          style: TextStyle(
                            color: Colors.brown,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0),
                Image.asset('assets/images/Login.jpeg', height: 300,width: 350),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabBar(
                    controller: tabController,
                    tabs: [
                      Tab(
                        text: "Login",
                        icon: Icon(Icons.home, color: Colors.brown),
                      ),
                      Tab(
                        text: "Register",
                        icon: Icon(Icons.email, color: Colors.brown),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 30),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Enter email',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: passController,
                              obscureText: !isObscure,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(color: Colors.brown),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  loginData(
                                    BuildContext,
                                    context,
                                    emailController,
                                    passController,
                                  );
                                });
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: Size(double.infinity, 50),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(child: Text('Or continue with')),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: Image.asset('assets/images/google3.jpeg',height: 40,width: 40),
                                    onPressed: (){}
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  icon:  Image.asset('assets/images/facebook.png', height: 40,width: 40),
                                  onPressed: () {},
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  icon: Image.asset('assets/images/github.png', height: 40,width: 40),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(child: Textfiled('First Name')),
                                SizedBox(width: 20),
                                Expanded(child: Textfiled('Last Name')),
                              ],
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Enter email',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: passController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: passController,
                              obscureText: isConfirmPasswordVisible,
                              decoration: InputDecoration(
                                labelText: ' Conform Password',
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isConfirmPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                    });
                                  },
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                              ),
                            ),

                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  register(
                                    BuildContext,
                                    context,
                                    emailController,
                                    passController,
                                    nameController,
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: Size(double.infinity, 50),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
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

Future<void> loginData(buildContext, context,
    dynamic emailController,
    dynamic passController) async {
  var response = await http.post(
    Uri.parse('https://sathwarainfotech.com/developer/reviewsentinelai/login2.php'),
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "origin",
      "Access-Control-Allow-Credentials": "true",
    },
    body: jsonEncode({
      "email": emailController.text,
      "password": passController.text,

    }),
  );
  if (response.statusCode == 200) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadScreen()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.indigo,
        duration: Duration(seconds: 1),
        content: Text("Login Successfully"),
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

Future<void> register(buildContext, context,
    dynamic emailController,
    dynamic passController,
    dynamic nameController) async {
  var response = await http.post(
    Uri.parse('https://sathwarainfotech.com/developer/reviewsentinelai/register2.php'),
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "origin",
      "Access-Control-Allow-Credentials": "true",
    },
    body: jsonEncode({
      "first_name": nameController.text,
      "last_name": nameController.text,
      "email": emailController.text,
      "password": passController.text,
      "conform_password": passController.text,
    }),
  );
  if (response.statusCode == 200) {
    Navigator.push(context, MaterialPageRoute(builder:( context)=> UploadScreen()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.indigo,
        duration: Duration(seconds: 1),
        content: Text("register Successfully"),
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




