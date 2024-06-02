import 'package:flutter/material.dart';

import 'chat/components/chat_list_view.dart';
import 'chat/global.dart';
import 'chat/model/message_model.dart';


class MyChatApp extends StatefulWidget {
  const MyChatApp({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  MyChatAppState createState() => MyChatAppState();
}

class MyChatAppState extends State<MyChatApp> {
  TextEditingController textEditingController = TextEditingController();
  late String senderMessage, receiverMessage;
  ScrollController scrollController = ScrollController();

  Future<void> scrollAnimation() async {
    return await Future.delayed(
        const Duration(milliseconds: 100),
        () => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4D5482),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF4D5482),
        leadingWidth: 50.0,
        titleSpacing: -8.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Add this line
          onPressed: () => Navigator.pop(context), // Add this line
        ),
        title: ListTile(
          title: Text(widget.userId,
              style: const TextStyle(
                color: Colors.white,
              )),
          subtitle: const Text('online',
              style: TextStyle(
                color: Colors.white70,
              )),
        ),
        actions: const [
          Icon(Icons.videocam),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: Icon(Icons.call),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ChatListView(scrollController: scrollController)),
          Container(
            // height: 50,
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromRGBO(215, 216, 218, 1),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 12.0),
                  child: Transform.rotate(
                      angle: 45,
                      child: const Icon(
                        Icons.attach_file_sharp,
                        color: Colors.white,
                      )),
                ),
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 6,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 11.0),
                  child: Transform.rotate(
                    angle: -3.14 / 5,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            messageList.add(
                                MessageData(textEditingController.text, true));
                            textEditingController.clear();
                            scrollAnimation();
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            messageList.add(
                                MessageData(textEditingController.text, false));
                            textEditingController.clear();
                            scrollAnimation();
                          });
                        },
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
