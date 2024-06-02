
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weforus/ProfileScreen.dart';
import 'package:weforus/login.dart';
import 'package:weforus/organization_dashboard.dart';
import 'package:weforus/signup.dart';
import 'package:weforus/volunteer_dashboard.dart';


import 'ApplicationList.dart';
import 'ManageApplications.dart';
import 'events.dart';
import 'explore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        secondaryHeaderColor: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(81, 130, 155,1), // background color
            onPrimary: Colors.white, // text color
            shadowColor: Colors.black, // shadow color
            elevation: 5, // elevation
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            padding: EdgeInsets.symmetric(horizontal: (deviceWidth-270), vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.green; // Thumb color when the switch is ON
            }
            return Colors.grey;// Thumb color when the switch is OFF
          }),
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.green.withOpacity(0.5); // Track color when the switch is ON
            }
            return Colors.grey.withOpacity(0.5); // Track color when the switch is OFF
          }),
          trackOutlineColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.green.withOpacity(0.1); // Track outline color when the switch is ON
            }
            return Colors.grey.withOpacity(0.1); // Track outline color when the switch is OFF
          }),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          surfaceTintColor: Color.fromRGBO(0, 195, 255, 0.8392156862745098),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          shadowColor: Colors.grey.withOpacity(0.3),
          elevation: 0.5,
          margin: EdgeInsets.all(4.0),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/profile': (context) =>  ProfileScreen(),
        '/applications': (context) =>  ManageApplicationsScreen(),
        '/applicationslist': (context) =>  ApplicationListScreen(),
        '/organizationDashboard': (context) =>  OrganizationDashboard(),
        '/volunteerDashboard': (context) =>  VolunteerDashboard(),
        '/exploreScreen': (context)=> ExploreScreen(),
        '/exploredevents': (context)=>Exploredevents()
      },
    );
  }
}
