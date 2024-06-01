import 'package:flutter/material.dart';
import 'package:weforus/volunteersidebar.dart';

class VolenteerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: volunteerDrawer(),
      appBar: AppBar(
        // title: const Text('Home'),
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
              children: [
                Text(
                  'Featured Events',
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
            // CurrentProgramCard(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  CurrentProgram(eventname:'Wildlife Habitat Enhancement', eventtopic: 'Everglades National Park, Florida',eventurl:'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',eventday: "12"),
                  CurrentProgram(eventname:'Wildlife Habitat Enhancement', eventtopic: 'Everglades National Park, Florida',eventurl:'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',eventday: "12"),
                  CurrentProgram(eventname:'Wildlife Habitat Enhancement', eventtopic: 'Everglades National Park, Florida',eventurl:'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',eventday: "12"),
                  CurrentProgram(eventname:'Wildlife Habitat Enhancement', eventtopic: 'Everglades National Park, Florida',eventurl:'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',eventday: "12"),

                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Organizations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(), // Pushes the next widget to the right
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
                children: <Widget>[
                  OrganizationCard(name: 'Planet Protectors'),
                  OrganizationCard(name: 'Clean Air Initiative'),
                  OrganizationCard(name: 'Unity in Action'),
                  OrganizationCard(name: 'Active Lives'),
                  OrganizationCard(name: 'Hope Crusaders'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Your Events',
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
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Yourevents(youreventname:'Wildlife Habitat Enhancement', youreventtopic: 'Everglades National Park, Florida',youreventurl:'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',youreventday: "12"),
                  Yourevents(youreventname:'Wildlife Habitat Enhancement', youreventtopic: 'Everglades National Park, Florida',youreventurl:'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',youreventday: "12"),
                  Yourevents(youreventname:'Wildlife Habitat Enhancement', youreventtopic: 'Everglades National Park, Florida',youreventurl:'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',youreventday: "12"),
                  Yourevents(youreventname:'Wildlife Habitat Enhancement', youreventtopic: 'Everglades National Park, Florida',youreventurl:'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',youreventday: "12"),


                ],
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize:  16, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
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




class Yourevents extends StatelessWidget {
  final String youreventname,youreventtopic,youreventurl,youreventday;

  Yourevents({required this.youreventname,required this.youreventtopic,required this.youreventurl,required this.youreventday});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 150.0,
                width: 350.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(youreventurl),
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
                    "${youreventday} days",
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
                  youreventname,

                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  youreventtopic,
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
