import 'package:flutter/material.dart';
import 'package:shared_preference/Login_without_validation/shared_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedLogin extends StatefulWidget {
  const SharedLogin({super.key});

  @override
  State<SharedLogin> createState() => _SharedLoginState();
}

class _SharedLoginState extends State<SharedLogin> {
  // controller of each field
  final uname_controller = TextEditingController();
  final pass_controller = TextEditingController();

  late SharedPreferences preferences;
  late bool isANewUser;

  @override
  void initState() {
    checkTheUserIsAlreadyLoggedIn();
    super.initState();
  }

  // To check alredy logged In

  void checkTheUserIsAlreadyLoggedIn() async {
    preferences = await SharedPreferences.getInstance();
    isANewUser = preferences.getBool('newuser') ?? true;
    //?? - is first statement is null second statement will execute
    if (isANewUser == false) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => Home_shared()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login Using Shared",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 34, 31),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: uname_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "UserName",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: pass_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Password",
                ),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 1, 34, 31),
              ),
              onPressed: () async {
                // future

                preferences = await SharedPreferences.getInstance();
                String email = uname_controller.text; // read email
                String pwd = pass_controller.text; // read pwd

                /// condition if email not equal to empty and pasword not equal to empty
                /// save to shared preference = email and password setString

                if (email != "" && pwd != "") {
                  preferences.setString(
                    "Email",
                    email,
                  ); // direct can we give uname_controller.text
                  preferences.setString("Pass", pwd); // pass_controller.text
                  preferences.setBool("newuser", false);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home_shared()),
                  );
                  uname_controller.text = ""; // clear the field
                  pass_controller.text = "";
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please fill all the Fields")),
                  );
                }
              },
              child: const Text(
                "Login Here",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
