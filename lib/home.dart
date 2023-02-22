import 'package:flutter/material.dart';
import 'package:gpt/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chatScreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text('ChatGPT'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: chatColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: bgColor,
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // margin: EdgeInsetsGeometry.infinity,
                    padding: EdgeInsets.all(25),
                    child: Text(
                      'Welcome to ChatGPT',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: bgColor,
                    backgroundImage: AssetImage('assets/icon_Chat.png'),
                    // radius: 20,
                    // minRadius: 20,
                    maxRadius: 40,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.all(25),
                    child: Text(
                      'ChatGPT is an AI-powered chatbot that can help you with a variety of tasks. It can answer your questions, provide recommendations, and even help you make reservations.',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to chat screen
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return ChatScreen();
                      }));
                    },
                    child: Text('Chat with ChatGPT'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.fromLTRB(140, 0, 100, 0),
              child: Text(
                'Useful Links',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.fromLTRB(154, 0, 100, 0),
              child: TextButton(
                onPressed: () async {
                  // Navigate to FAQ screen
                  var twtusername='https://twitter.com/OpenAI';
                  var urllaunchable = await canLaunchUrl(Uri.parse(twtusername));
                  if (urllaunchable) {
                    await launchUrl(
                      Uri.parse(twtusername),
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    print("URL can't be launched.");
                  }

                },
                child: Text('Twitter'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(150, 0, 100, 0),
              child: TextButton(
                onPressed: () async {
                  // Navigate to Contact Us screen
                  // String url = "https://www.fluttercampus.com";
                  // final Uri site = Uri(
                  //     scheme: 'https', host: 'openai.com', path: 'headers/');
                  var urllaunchable = await canLaunchUrl(Uri.parse('https://openai.com/blog/'));
                  if (urllaunchable) {
                    await launchUrl(
                      Uri.parse('https://openai.com/blog/'),
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    print("URL can't be launched.");
                  }
                },
                child: Text('View Blog'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
