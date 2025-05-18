//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/Profile.dart';
import 'package:flutter1/login.dart';

import '../aboutpage.dart';
import '../contact.dart';
import '../generated/assets.dart';
import '../help.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      backgroundColor: Colors.brown,
      shadowColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(Assets.imagesLogo, height: 50),
                TextButton(
                  onPressed: () {

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Loginpage()));
                  },
                  child: Text("Home", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                  },
                  child: Text(
                      "About Us", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Contactpage()));
                  },
                  child: Text(
                      "Contact Us", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)  => Help()));
                  },
                  child: Text("Help", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(width: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.brown,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }
}
