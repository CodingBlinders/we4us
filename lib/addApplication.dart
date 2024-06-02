import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddApplicationScreen extends StatefulWidget {
  final String eventId; // Add eventId to the widget constructor

  const AddApplicationScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  State<AddApplicationScreen> createState() => _AddApplicationScreenState(eventId);
}

class _AddApplicationScreenState extends State<AddApplicationScreen> {
  Map<String, dynamic>? eventData;

  _AddApplicationScreenState(String eventId);

  @override
  void initState() {
    super.initState();
    fetchEventData();
  }

  Future<void> fetchEventData() async {
    final String eventId = widget.eventId; // Access eventId from widget
    print(eventId);
    final response = await http.get(
        Uri.parse('http://192.168.86.121:4000/event/getEvent/$eventId')); // Use eventId in the URL

    if (response.statusCode == 200) {
      setState(() {
        eventData = json.decode(response.body);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (eventData == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
        title: Text('Event Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventData!['name'],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: eventData!['photoUrl'] != null
                    ? DecorationImage(
                  image: NetworkImage(eventData!['photoUrl']),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    // Handle image loading error
                    setState(() {
                      print("error");
                      print(exception);
                      eventData!['photoUrl'] = null;
                    });
                  },
                )
                    : null,
              ),
              child: eventData!['photoUrl'] == null
                  ? Icon(Icons.image, size: 100, color: Colors.grey[600])
                  : null,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  '${eventData!['startDate']} to ${eventData!['endDate']}\n9am onwards',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    'Environment',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  backgroundColor: Colors.black,
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  eventData!['location'],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.people, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  '${eventData!['numberOfVolunteers']} applied',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle apply now button press
                  // You can navigate to a registration page or perform another action
                },
                child: Text(
                  'Apply Now',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  eventData!['telephoneNumber'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              eventData!['description'],
              style: TextStyle(height: 1.5, fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              eventData!['notes'],
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '• Please submit your volunteer application by ${eventData!['deadline']}.',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
