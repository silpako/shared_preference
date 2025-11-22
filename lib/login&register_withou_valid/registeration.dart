import 'package:flutter/material.dart';
import 'package:shared_preference/login&register_withou_valid/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register_shared extends StatefulWidget {
  const Register_shared({super.key});

  @override
  State<Register_shared> createState() => _Register_sharedState();
}

class _Register_sharedState extends State<Register_shared> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: const Color.fromARGB(255, 8, 157, 144),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 8, 157, 144),
              ),
              onPressed: () async {
                var prefs = await SharedPreferences.getInstance();

                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passController.text.isNotEmpty) {
                  /// Store details
                  prefs.setString("reg_name", nameController.text);
                  prefs.setString("reg_email", emailController.text);
                  prefs.setString("reg_pass", passController.text);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Registered Successfully!")),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login_Shared(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please fill all fields")),
                  );
                }
              },
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
