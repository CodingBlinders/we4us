import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import 'login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _selectedRole = 'Volunteer';

  bool _isObscure = true; // Track whether the password is obscured or not
  bool _isObscure1 = true;
  Future<void> _signup() async {

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve user data from SharedPreferences
    // String userId = prefs.getString('userId') ?? '';
    // String userEmail = prefs.getString('userEmail') ?? '';
    // String userRole = prefs.getString('userRole') ?? '';
    // String userToken = prefs.getString('userToken') ?? '';
    //
    // // Now you can use the retrieved data as needed
    // print('User ID: $userId');
    // print('User Email: $userEmail');
    // print('User Role: $userRole');
    // print('User Token: $userToken');

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://192.168.86.121:4000/signup'));
    request.body = json.encode({
      "email": _emailController.text,
      "password": _passwordController.text,
      "name": _nameController.text,
      "role": _selectedRole
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      final responseData = await response.stream.bytesToString();
      final userDataJson = json.decode(responseData);

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
      print(responseData);
      if(userRole == 'user'){
        Navigator.pushNamed(context, '/volunteerDashboard');
      }else{
        Navigator.pushNamed(context, '/organizationDashboard');
      }

    } else {
      toastification.show(
        context: context,
        title: Text(response.reasonPhrase.toString()),
        autoCloseDuration: const Duration(seconds: 2),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        alignment: Alignment.bottomCenter,
        direction: TextDirection.ltr,
        showProgressBar: false,
        closeButtonShowType: CloseButtonShowType.none,
        closeOnClick: false,
        pauseOnHover: false,
        dragToClose: true,
        applyBlurEffect: true,
      );
      // print(response.reasonPhrase);
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
            Text('Create an Account',
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.0,),
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
            SizedBox(height: 10), // Add gap between input fields and labels
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
                    obscureText: _isObscure1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '********',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 163, 163, 163),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0), // Adjust padding



                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure1 ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure1 = !_isObscure1;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Add gap between input fields and labels
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirm Password',
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
                    controller: _confirmPasswordController,
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
            SizedBox(height: 10), // Add gap between input fields and labels
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                _buildInputField(_nameController, 'Saman Kumara'),
              ],
            ),
            SizedBox(height: 10), // Add gap between input fields and labels
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Role',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
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
                  child: DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),


                    ),

                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRole = newValue!;
                      });
                    },
                    isExpanded: true,
                    items: <String>['Volunteer', 'Organization']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(

                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
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
              child: Text('Sign Up',style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold

              ),),
            ),
            SizedBox(height: 6.0,),
            Text('or Sign up with',style: TextStyle(
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
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text(
                'Already a Member? Sign In',
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

