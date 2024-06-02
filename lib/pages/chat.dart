
import 'package:flutter/material.dart';

import '../active_chat.dart';
import '../chat/components/my_drawer.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<String> messages = [
    "I'd like to volunteer for the ...",
    "I'd like to volunteer for the ...",
    "I'd like to volunteer for the ...",
    "I'd like to volunteer for the ...",
    "I'd like to volunteer for the ...",
    "I'd like to volunteer for the ...",
    "I'd like to volunteer for the ...",
    "I'd like to volunteer for the ...",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Messages',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                          backgroundColor: Colors
                              .blue, // Change this to your preferred color
                        ),
                        title: Text(
                          'Gary Monroe',
                          style: TextStyle(
                            color: Colors
                                .black, // Change this to your preferred color
                            fontWeight: FontWeight.bold, // Makes the text bold
                          ),
                        ),
                        subtitle: Text(
                          messages[index],
                          style: TextStyle(
                            color: Colors
                                .grey, // Change this to your preferred color
                          ),
                        ),
                        tileColor:
                            Colors.white, // Change this to your preferred color
                        contentPadding: const EdgeInsets.all(10), // Adds padding to the ListTile
                            onTap: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyChatApp(
                                  userId: 'Gary Monroe', // Pass the message as a parameter
                                ),
                              ),
                            );
                          },
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ); // Adds a divider between ListTiles
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
