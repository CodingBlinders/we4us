import 'package:flutter/material.dart';
import 'package:weforus/sidebar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Organization {
  final String id;
  final String name;
  final String email;

  Organization({required this.id, required this.name, required this.email});

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class OrganizationDashboard extends StatefulWidget {
  @override
  _OrganizationDashboardState createState() => _OrganizationDashboardState();
}

class _OrganizationDashboardState extends State<OrganizationDashboard> {
  List<Organization> organizations = [];
  List events = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrganizations();
    fetchEvents();
  }

  fetchEvents() async {
    var headers = {
      'Cookie': 'token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NWJjMTcwMjMwOThiMDkyMzc0MmY2OCIsImlhdCI6MTcxNzI5NTU2MCwiZXhwIjoxNzE3NTU0NzYwfQ.RNlDxU6PZvl1nAe6MyMajaEyRr_8walsXI6Pj4MCp38'
    };
    var request = http.Request('GET', Uri.parse('http://192.168.86.121:4000/event/getEvents'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      setState(() {
        events = json.decode(responseBody);
        isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> fetchOrganizations() async {
    var headers = {
      'Cookie': 'token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NWJjMTcwMjMwOThiMDkyMzc0MmY2OCIsImlhdCI6MTcxNzI5NTU2MCwiZXhwIjoxNzE3NTU0NzYwfQ.RNlDxU6PZvl1nAe6MyMajaEyRr_8walsXI6Pj4MCp38'
    };
    var request = http.Request('GET', Uri.parse('http://192.168.86.121:4000/user/getOrganizations'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseBody);
      List<Organization> fetchedOrganizations = (jsonData['users'] as List)
          .map((data) => Organization.fromJson(data))
          .toList();
      setState(() {
        organizations = fetchedOrganizations;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SearchBar(
              onSearch: (query) {
                // Implement your search logic here
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StatCard(title: 'Projects Completed', value: '1.3K'),
                StatCard(title: 'Active Volunteers', value: '754'),
                StatCard(title: 'Donations Received', value: '\$6M+'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Next Event',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (events.isNotEmpty)
              NextEventCard(
                nexteventname: events[0]['name'],
                nexteventtopic: events[0]['area'],
                nexteventurl: events[0]['photoUrl'],
                nexteventday: "2", // This can be computed based on the current date and event date
              ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Organizations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // Add your onTap functionality here
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: organizations.map((org) => OrganizationCard(name: org.name)).toList(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Current Programs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // Add your onTap functionality here
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
    SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
    children: events.map((event) {
    return CurrentProgram(
    eventname: event['name'],
    eventtopic: event['area'],
    eventurl: event['photoUrl'],
    eventday: "12", // This can be computed based on the current date and event date
    );
    }).toList(),
    ),
    ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement your action here
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}


class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller = TextEditingController();

  void _clearSearch() {
    setState(() {
      _controller.clear();
      widget.onSearch('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: _controller,
        onChanged: widget.onSearch,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearSearch,
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(

        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextEventCard extends StatelessWidget {
  final String nexteventname,nexteventtopic,nexteventurl,nexteventday;

  NextEventCard({required this.nexteventname,required this.nexteventtopic,required this.nexteventurl,required this.nexteventday});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(nexteventurl),
                    fit: BoxFit.cover,
                  ),
                  // color: Colors.grey[300],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                ),

                // child: Center(
                //
                //   // child: Icon(
                //   //   Icons.image,
                //   //   size: 50.0,
                //   //   color: Colors.grey[500],
                //   // ),
                // ),
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    "${nexteventday} days",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  nexteventname,

                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  nexteventtopic,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[700],
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

class OrganizationCard extends StatelessWidget {
  final String name;

  OrganizationCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            child: Text(
              name[0],
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          SizedBox(height: 5),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}




class CurrentProgram extends StatelessWidget {
  final String eventname,eventtopic,eventurl,eventday;

  CurrentProgram({required this.eventname,required this.eventtopic,required this.eventurl,required this.eventday});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 120.0,
                width: 300.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(eventurl),
                    fit: BoxFit.cover,
                  ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0)),
                ),
                // child: Center(
                //   // child: Icon(
                //   //   Icons.image,
                //   //   size: 50.0,
                //   //   color: Colors.grey[500],
                //   // ),
                // ),
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    "${eventday} days",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  eventname,

                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  eventtopic,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[700],
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


