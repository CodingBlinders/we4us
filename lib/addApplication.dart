import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddApplicationScreen extends StatefulWidget {
  const AddApplicationScreen({super.key});

  @override
  State<AddApplicationScreen> createState() => _AddApplicationScreenState();
}

class _AddApplicationScreenState extends State<AddApplicationScreen> {
  Map<String, dynamic>? eventData;

  @override
  void initState() {
    super.initState();
    fetchEventData();
  }

  Future<void> fetchEventData() async {
    print('called');
    var request = http.Request(
      'GET',
      Uri.parse('http://192.168.86.121:4000/event/getEvent/665b9ffeb75f9bb42f5de070'),
    );
    var headers = {
      'Cookie':
      'jwtToken=eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzaW5ldGgyIiwiZXhwIjoxNzE2OTE3MjEyLCJpYXQiOjE3MTY4OTkyMTJ9.9tvJpLhJa-m2tjqxUHLHey2xIoJjCrjfVGDdK8UQfmqjQ0Aub5ldwMBNrwt_IBCqw90sGnXFNb3ZDnfl4U8ezQ; token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NWI2Nzg3YWVhMWNhZTU1OTlhMTkyMCIsImlhdCI6MTcxNzI4MDczNCwiZXhwIjoxNzE3NTM5OTM0fQ.yrMjRONItuEExRgn4uy3KNm4ZCqGTOe5fNd4zJ0bOTQ'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      setState(() {
        eventData = json.decode(responseBody);
      });
    } else {
      print(response.reasonPhrase);
    }
    print(eventData);
    print(eventData!['photoUrl']);
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
            // Handle back button press
          },
        ),
        title: Text('Event Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventData!['name'],
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
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
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('Environment',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16)),
                    backgroundColor: Colors.black,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(eventData!['location'],
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.people, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('${eventData!['numberOfVolunteers']} applied',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle apply now button press
                    // You can navigate to a registration page or perform another action
                  },
                  child: Text('Apply Now', style: const TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(eventData!['telephoneNumber'],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 8),
              Text(
                eventData!['description'],
                style: TextStyle(height: 1.5, fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(eventData!['notes'], style: const TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(
                  '• Please submit your volunteer application by ${eventData!['deadline']}.',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
