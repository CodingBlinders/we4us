import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weforus/ProfileScreen.dart';
import 'package:weforus/addApplication.dart';
import 'package:weforus/login.dart';
import 'package:weforus/signup.dart';


import 'ApplicationList.dart';
import 'ManageApplications.dart';

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
      ),

      initialRoute: '/addApllication',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/profile': (context) =>  ProfileScreen(),
        '/applications': (context) =>  ManageApplicationsScreen(),
        '/applicationslist': (context) =>  ApplicationListScreen(),
        '/addApllication': (context) =>  AddApplicationScreen(),
      },
    );
  }
}
