import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Green Planet"),
            accountEmail: Text("testing@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/logo.png'),
              child: Text("G"),
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
              Navigator.pushNamed(context, '/manageapplications');
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Programs'),
            onTap: () {
              // Handle the tap event
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
              // Handle the tap event
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chats'),
            onTap: () {
              // Handle the tap event
            },
          ),
        ],
      ),
    );
  }
}
