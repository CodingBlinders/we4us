import 'package:flutter/material.dart';



class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int organizationRating = 0;
  int communicationRating = 0;
  int supportRating = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  Widget buildStarRating(int rating, Function(int) onRatingChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
          ),
          color: Colors.amber,
          onPressed: () => onRatingChanged(index + 1),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review'),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.grey[200],
                child: Icon(Icons.upload_file),
              ),
              SizedBox(height: 16),
              Text(
                'Nature Nurturers Rally',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('May 27, 2024'),
              SizedBox(height: 16),
              Text('How would you rate this event?'),
              buildStarRating(organizationRating, (rating) {
                setState(() {
                  organizationRating = rating;
                });
              }),
              Text('Organization'),
              buildStarRating(communicationRating, (rating) {
                setState(() {
                  communicationRating = rating;
                });
              }),
              Text('Communication'),
              buildStarRating(supportRating, (rating) {
                setState(() {
                  supportRating = rating;
                });
              }),
              Text('Support'),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Review Title',
                ),
              ),
              TextField(
                controller: reviewController,
                decoration: InputDecoration(
                  labelText: 'Review',
                ),
                maxLines: 5,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle the submit action
                  print('Title: ${titleController.text}');
                  print('Review: ${reviewController.text}');
                  print('Organization Rating: $organizationRating');
                  print('Communication Rating: $communicationRating');
                  print('Support Rating: $supportRating');
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
