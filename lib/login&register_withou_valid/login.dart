import 'package:flutter/material.dart';
import 'package:shared_preference/login&register_withou_valid/home.dart';
import 'package:shared_preference/login&register_withou_valid/registeration.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Login_Shared extends StatefulWidget {
  const Login_Shared({super.key});

  @override
  State<Login_Shared> createState() => _Login_SharedState();
}

class _Login_SharedState extends State<Login_Shared> {
  final uname_controller = TextEditingController();
  final pass_controller = TextEditingController();

  late SharedPreferences preferences;
  late bool isANewUser;

  @override
  void initState() {
    checkTheUserIsAlreadyLoggedIn();
    super.initState();
  }

  void checkTheUserIsAlreadyLoggedIn() async {
    preferences = await SharedPreferences.getInstance();
    isANewUser = preferences.getBool('newuser') ?? true;

    if (isANewUser == false) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Using Shared"),
        backgroundColor: const Color.fromARGB(255, 8, 157, 144),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome Back",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // Username field
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: uname_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Email",
                ),
              ),
            ),

            // Password field
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: pass_controller,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Password",
                ),
              ),
            ),

            // Login Button
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 1, 34, 31),
              ),
              onPressed: () async {
                preferences = await SharedPreferences.getInstance();

                String inputEmail = uname_controller.text;
                String inputPwd = pass_controller.text;

                /// Read REGISTERED values
                String savedEmail = preferences.getString("reg_email") ?? "";
                String savedPass = preferences.getString("reg_pass") ?? "";

                if (inputEmail == savedEmail && inputPwd == savedPass) {
                  preferences.setBool("newuser", false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Invalid Credentials")),
                  );
                }
              },
              child: const Text(
                "Login Here",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 10),

            // Register button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register_shared(),
                  ),
                );
              },
              child: const Text("New User? Register Here"),
            ),
          ],
        ),
      ),
    );
  }
}
