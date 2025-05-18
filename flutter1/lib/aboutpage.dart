import 'package:flutter/material.dart';
import 'package:flutter1/widget/app_bar.dart';

import 'generated/assets.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                      'About Us',
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
              children: [
                Image.network(
                  'https://st2.depositphotos.com/3591429/10464/i/450/depositphotos_104648666-stock-photo-group-of-people-brainstorming-on.jpg',
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 120),
                Expanded(
                  child: Text(
                    'Theory reviews could have one or more of the following aims: identifying and mapping \na '
                    'comprehensive range of relevant theories; assessing which theories have become \ninfluential'
                    ' and which have been, or have become over time, largely overlooked; and \nintegrating '
                    'complementary theories and facilitating the analysis \n '
                    'AI emotion recognition is a very active current field of computer vision research that \ninvolves'
                    ' facial emotion detection and the automatic assessment of sentiment from visual data and \ntext '
                    'analysis. Human-machine interaction is an important area of research where machine \nlearning '
                    'algorithms with visual perception aim to gain an understanding of human \ninteraction'
                    ' About us: Viso.ai provides the end-to-end computer vision platform Viso Suite. This \nsolution '
                    ' enables leading companies to build, deploy, and scale their AI vision applications, including \nAI'
                    ' emotion analysis. Get a personalized demo for your organization.'
                    'Theory reviews could have one or more of the following aims: identifying and mapping \na '
                    'comprehensive range of relevant theories; assessing which theories have become \ninfluential'
                    ' and which have been, or have become over time, largely overlooked; and \nintegrating '
                    'complementary theories and facilitating the analysis \n '
                    'AI emotion recognition is a very active current field of computer vision research that \ninvolves'
                    ' facial emotion detection and the automatic assessment of sentiment from visual data and \ntext '
                    'analysis. Human-machine interaction is an important area of research where machine \nlearning '
                    'algorithms with visual perception aim to gain an understanding of human \ninteraction'
                    ' About us: Viso.ai provides the end-to-end computer vision platform Viso Suite. This \nsolution '
                    ' enables leading companies to build, deploy, and scale their AI vision applications, including \nAI'
                    ' emotion analysis. Get a personalized demo for your organization.'
                    'Theory reviews could have one or more of the following aims: identifying and mapping \na '
                    'comprehensive range of relevant theories; assessing which theories have become \ninfluential'
                    ' and which have been, or have become over time, largely overlooked; and \nintegrating '
                    'complementary theories and facilitating the analysis \n '
                    'AI emotion recognition is a very active current field of computer vision research that \ninvolves'
                    ' facial emotion detection and the automatic assessment of sentiment from visual data and \ntext '
                    'analysis. Human-machine interaction is an important area of research where machine \nlearning '
                    'algorithms with visual perception aim to gain an understanding of human \ninteraction'
                    ' About us: Viso.ai provides the end-to-end computer vision platform Viso Suite. This \nsolution '
                    ' enables leading companies to build, deploy, and scale their AI vision applications, including \nAI'
                    ' emotion analysis. Get a personalized demo for your organization.',

                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              onPressed: () {},
              child: SizedBox(
                width: 120,
                height: 20,
                child: Text(
                  'More contain',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
