import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Icon(
                Icons.message,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('H O M E'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('S E T T I N G S'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                
                MaterialPageRoute(builder: (context) => const Placeholder()); // setttings page
              }
            ),
          ),

          Padding(padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('L O G O U T'),
              leading: Icon(Icons.logout),
              onTap: () {
                Navigator.pop(context);
                
                MaterialPageRoute(builder: (context) => const Placeholder()); // about page
              }
            ),
          ),
        ],
      ),
    );
  }
}
