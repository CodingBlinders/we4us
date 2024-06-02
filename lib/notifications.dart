import 'package:flutter/material.dart';



class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          NotificationSection(
            title: 'New',
            notifications: [
              NotificationItem(
                message: 'Your application on Mexican Stoves Project was approved.',
                time: '6 hours ago',
              ),
              NotificationItem(
                message: 'Your application for the Carbon Neutral Program was sent successfully.',
                time: '1 day ago',
              ),
            ],
          ),
          NotificationSection(
            title: 'Earlier',
            notifications: [
              NotificationItem(
                message: 'Your application on Protecting the Arctic was rejected.',
                time: '1 week ago',
              ),
              NotificationItem(
                message: 'Your application for the Protecting the Arctic was sent successfully.',
                time: '2 weeks ago',
              ),
              NotificationItem(
                message: 'Have a look at your contribution in the past month.',
                time: '2 weeks ago',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  final String title;
  final List<NotificationItem> notifications;

  NotificationSection({required this.title, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Column(
            children: notifications,
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String message;
  final String time;

  NotificationItem({required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.notifications),
      ),
      title: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(time),
    );
  }
}
