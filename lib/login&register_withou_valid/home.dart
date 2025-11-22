import 'package:flutter/material.dart';
import 'package:shared_preference/login&register_withou_valid/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences preferences;
  late String username;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("reg_name") ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hi, $username",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
            preferences.setBool("newuser", true); // only login resets

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Login_Shared()),
            );
          },
          child: const Text("Logout", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
