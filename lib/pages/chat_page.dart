import 'package:chat_app/Models/Message.dart';
import 'package:chat_app/Widgets/chatBuble.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  CollectionReference messagesDB = FirebaseFirestore.instance.collection(
    'messages',
  );

  ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();
  String currentText = "";
  ChatPage({super.key});
  static final String id = '3';
  @override
  Widget build(BuildContext context) {
    String userEmail = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/scholar.png", height: 75),
            Text(
              "Chat",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: messagesDB.orderBy('CreatedAt', descending: true).snapshots(),

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,

                    reverse: true,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      if (userEmail == messagesList[index].email)
                        return ChatBubble(message: messagesList[index]);
                      else
                        return StrangerChatBubble(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 16,
                    top: 16,
                  ),
                  child: Container(
                    height: 60,
                    child: TextField(
                      controller: textController,
                      onChanged: (value) => currentText = value,
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          messagesDB.add({
                            "Text": value,
                            "CreatedAt": DateTime.now(),
                            "Email": userEmail,
                          });
                        }
                        ;
                        textController.clear();
                        scrollController.animateTo(
                          0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                        FocusScope.of(context).unfocus();
                      },
                      style: TextStyle(
                        decorationThickness: 0,
                        color: kPrimaryColor,
                      ),
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hint: Text("Type a message"),
                        hintStyle: TextStyle(color: Colors.grey),
                        suffix: IconButton(
                          onPressed: () {
                            if (currentText.trim().isNotEmpty) {
                              messagesDB.add({
                                "Text": currentText,
                                "CreatedAt": DateTime.now(),
                                "Email": userEmail,
                              });
                            }
                            ;
                            textController.clear();
                            scrollController.animateTo(
                              0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                            FocusScope.of(context).unfocus();
                          },
                          icon: Icon(Icons.send),
                          color: kPrimaryColor,
                        ),
                        //hintText: "Type a message",
                        // hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error Call Mazen"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
