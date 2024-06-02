import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: const UserAccountsDrawerHeader(
              accountName: Text("Green Planet"),
              accountEmail: Text("testing@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/logo.png'),
                child: Text("G"),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/organizationDashboard');
            },
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('Applications'),
            onTap: () {
              Navigator.pushNamed(context, '/applications');
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Events'),
            onTap: () {
              Navigator.pushNamed(context, '/exploredevents');
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Volunteers'),
            onTap: () {
              // Handle the tap event
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chats'),
            onTap: () {
              Navigator.pushNamed(context, '/chat');
            },
          ),
        ],
      ),
    );
  }
}
