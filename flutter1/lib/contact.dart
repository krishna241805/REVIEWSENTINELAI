import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter1/widget/app_bar.dart';

import 'generated/assets.dart';
import 'widget/infobox_contact_widget.data.dart';

class Contactpage extends StatelessWidget {
  const Contactpage({super.key});

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
                      'Contact Us',
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
                  title: 'About',
                  content: 'information about review sentinel and its mission',
                ),

                InfoBox(
                  color: Colors.teal,
                  title: 'Contact',
                  content: 'ReviewsentinelAI.com',
                ),
                InfoBox(
                  color: Colors.lightBlueAccent,
                  title: 'Address',
                  content: 'abc',
                ),
              ],
            ),
            SizedBox(height: 100),
            HtmlWidget(
              '''
              <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3671.5035620103445!2d72.6759199743683!3d23.041993115605017!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x395e86e4541ebce9%3A0xce005acafc77ce95!2sSathwara%20InfoTech!5e0!3m2!1sen!2sin!4v1742994332148!5m2!1sen!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
              ''',
              customStylesBuilder: (element) {
                if (element.classes.contains('foo')) {
                  return {'color': 'yellow'};
                }
                return null;
              },
              renderMode: RenderMode.column,
              textStyle: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
