import 'package:flutter/material.dart';

class Exploredevents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button action here
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( // Wrap both SingleChildScrollView inside a Column
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  SkillChip(label: 'Communication', isSelected: true),
                  SkillChip(label: 'Time Management'),
                  SkillChip(label: 'Adaptability'),
                  SkillChip(label: 'Problem Solving', isSelected: true),
                  SkillChip(label: 'Teamwork', isSelected: true),
                ],
              ),
            ),
            SizedBox(height: 20), // Added for spacing
            Expanded( // Use Expanded to allow the SingleChildScrollView to occupy remaining space
              child: SingleChildScrollView(
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
            ),
          ],
        ),
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
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 150.0,
                // width: 350.0,
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


class SkillChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  SkillChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle skill chip tap
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0), // Adjust the horizontal spacing as needed
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
