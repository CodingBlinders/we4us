import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:weforus/signup.dart';
import 'package:weforus/volunteer_dashboard.dart';

import 'organization_dashboard.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  @override
  void initState()  {
    super.initState();

  }


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  bool _isObscure = true; // Track whether the password is obscured or not

  Future<void> _signup() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://192.168.86.121:4000/login'));
    request.body = json.encode({
      'email': _emailController.text,
      'password': _passwordController.text,

    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();



    if (response.statusCode == 202) {
      final responseData = await response.stream.bytesToString();
      final userDataJson = json.decode(responseData);

      print(userDataJson);
      // Extracting data from the response
      String userId = userDataJson['user']['_id'];
      String userEmail = userDataJson['user']['email'];
      String userRole = userDataJson['user']['role'];
      String userToken = userDataJson['user']['token'];



      // Store user data in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);
      await prefs.setString('userEmail', userEmail);
      await prefs.setString('userRole', userRole);
      await prefs.setString('userToken', userToken);

      print(userRole) ;

      toastification.show(
        context: context,
        title: Text('Successfully Signed In!',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),),
        autoCloseDuration: const Duration(seconds: 3),
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        alignment: Alignment.topCenter,
        direction: TextDirection.ltr,
        showProgressBar: false,
        closeButtonShowType: CloseButtonShowType.none,
        closeOnClick: false,
        pauseOnHover: true,
        dragToClose: true,
        applyBlurEffect: true,
      );
      if(userRole == 'organization'){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OrganizationDashboard(),
          ),
        );

      }
      else if(userRole=='user'){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => VolunteerDashboard(),
          ),
        );

      }


    } else {
      final responseData = await response.stream.bytesToString();
      final userDataJson = json.decode(responseData);

      toastification.show(
        context: context,
        title: Text(userDataJson['message'],style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),),
        autoCloseDuration: const Duration(seconds: 3),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        alignment: Alignment.topCenter,
        direction: TextDirection.ltr,
        showProgressBar: false,
        closeButtonShowType: CloseButtonShowType.none,
        closeOnClick: false,
        pauseOnHover: true,
        dragToClose: true,
        applyBlurEffect: true,
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Welcome Back!',
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 100.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Text(
                  'Email',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                _buildInputField(_emailController, 'user@mail.com'),
              ],
            ),
            SizedBox(height: 20), // Add gap between input fields and labels
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 30,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '********',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 163, 163, 163),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0), // Adjust padding



                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 80), // Add gap between input fields and labels

            SizedBox(height: 30), // Add larger gap after last input field
            ElevatedButton(
              onPressed: _signup,
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(223, 217, 217, 217), // Set button color to gray
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Set border radius
                ),
                minimumSize: Size(190, 50), // Set button size
              ),
              child: Text('Sign In',style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold

              ),),
            ),
            SizedBox(height: 20.0,),
            Text('or Sign in with',style: TextStyle(
              color: Colors.grey
            ),),
            Row(

              mainAxisAlignment: MainAxisAlignment.center, // Adjust the spacing between buttons

              children: [
                IconButton(onPressed: (){}, icon: Icon(
                  Icons.mail,
                  color: Colors.grey,),
                  iconSize: 24,),
                IconButton(onPressed: (){}, icon: Icon(
                  Icons.facebook,
                  color: Colors.grey,),
                  iconSize: 24,),
                IconButton(onPressed: (){}, icon: Icon(
                  Icons.apple,
                  color: Colors.grey,),
                  iconSize: 24,)
              ],
            ),
            SizedBox(height: 30.0,),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                   );
              },
              child: Text(
                'Don\'t have an Account? Signup',
                              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 30,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,

        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 163, 163, 163),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0), // Adjust padding



        ),
      ),
    );
  }
}

