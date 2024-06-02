import 'package:flutter/material.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isAvailable = false;
  bool notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      body: Container(
        width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [


              SizedBox(height: 16.0),
              CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(height: 10.0),
              Text(
                'Green Planet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Colombo, Sri Lanka',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 4.0),
              Text(
                'greenplanet11@gmail.com',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '1.3 K',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Events'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '5.7 K',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Followers'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '128',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Following'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Divider(),
              ListTile(
                title: Text('Available'),
                trailing: Switch(
                  value: isAvailable,
                  onChanged: (value) {
                    setState(() {
                      isAvailable = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Notifications'),
                trailing: Switch(
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Impact Statistics'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                title: Text('Certifications'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                title: Text('Feedbacks'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  //button size 100px
                  minimumSize: Size(100, 50),
                ),
                child: Text('Logout'),
              ),
            ],
          ),
        ),

    );
  }
}
