import 'package:flutter/material.dart';
import 'dart:convert';

class ApplicationListScreen extends StatelessWidget {
  Future<List<Application>> fetchApplications() async {
    // Simulate fetching data from an API
    final jsonResponse = '''
    [
      {"name": "Gary Monroe", "project": "Mexican Stoves Project", "time": "6 hours ago"},
      {"name": "Jane Doe", "project": "Water Supply Project", "time": "1 day ago"},
      {"name": "John Smith", "project": "Solar Panel Project", "time": "2 days ago"}
     
    ]
    ''';

    final data = jsonDecode(jsonResponse) as List;
    return data.map((json) => Application.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final String key = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Applications'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Handle back button pressed
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Applications',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder<List<Application>>(
                future: fetchApplications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No applications found.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final application = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.person),
                            ),
                            title: Text('${application.name} sent an application for ${application.project}.'),
                            subtitle: Text(application.time),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Application {
  final String name;
  final String project;
  final String time;

  Application({required this.name, required this.project, required this.time});

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      name: json['name'],
      project: json['project'],
      time: json['time'],
    );
  }
}
