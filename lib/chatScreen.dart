import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gpt/chat_model.dart';
import 'package:gpt/colors.dart';

import 'apiservices.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var text = 'Hello what can you do for me?';
  final List<ChatMessage> messages = [];
  var scrollController = ScrollController();
  TextEditingController txt = TextEditingController();

  scrollMethod() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        backgroundColor: bgColor,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: bgColor,
              backgroundImage: AssetImage('assets/icon_Chat.png'),
              // radius: 20,
              // minRadius: 20,
              // maxRadius: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text("ChatGPT")
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(12),
                color: chatColor,
              ),
              child: messages.isEmpty
                  ? Container(
                    // color: Colors.amber,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      padding: EdgeInsets.fromLTRB(150, 280, 25, 50),
                      child: Text("Say Hello....",style: TextStyle(color: Colors.white),),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var chat = messages[index];

                        return chatBubble(chattext: chat.text, type: chat.type);
                      },
                    ),
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: txt,
                          decoration: InputDecoration(
                              hintText: "Write a Message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          // print(text);
                          var text = txt.text;
                          setState(() {
                            txt.clear();

                            messages.add(ChatMessage(
                                text: text, type: ChatMessageType.user));
                          });
                          var msg = await ApiServices.sendMessage(text);

                          setState(() {
                            messages.add(ChatMessage(
                                text: msg, type: ChatMessageType.bot));
                          });
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: bgColor,
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget chatBubble({required chattext, required ChatMessageType? type}) {
    return Align(
      alignment:
          type == ChatMessageType.bot ? Alignment.topLeft : Alignment.topRight,
      child: Expanded(
        child: Container(
          width: type == ChatMessageType.bot ? 250 : null,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: type == ChatMessageType.bot ? bgColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$chattext',
            style: TextStyle(
              color: type == ChatMessageType.bot ? Colors.white : chatColor,
              fontSize: 15,
              fontWeight: type == ChatMessageType.bot
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
