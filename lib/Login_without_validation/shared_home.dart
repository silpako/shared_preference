import 'package:flutter/material.dart';
import 'package:shared_preference/Login_without_validation/shared_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_shared extends StatefulWidget {
  @override
  State<Home_shared> createState() => _Home_sharedState();
}

class _Home_sharedState extends State<Home_shared> {
  late SharedPreferences preferences;
  late String username; // save came name  from previous page

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // read the value
  void fetchData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      // change user name
      username = preferences.getString("Email")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hi, $username",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 34, 31),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 1, 34, 31),
          ),
          onPressed: () async {
            preferences = await SharedPreferences.getInstance();
            preferences.setBool("newuser", true); // user logged out
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => SharedLogin()));
          },
          child: Text(
            "LogOut",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
