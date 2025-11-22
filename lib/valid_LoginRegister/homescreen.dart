

// ------------------------ Home Screen ------------------------
import 'package:flutter/material.dart';
import 'package:shared_preference/valid_LoginRegister/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _name = 'User';
  bool _loading = true;

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('reg_name') ?? 'User';

    if (!mounted) return;
    setState(() {
      _name = name;
      _loading = false;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('newuser', true); // only reset login state

    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, $_name'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Welcome back, $_name!', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 20),
                  FilledButton.tonal(
                    onPressed: _logout,
                    child: const Text('Logout'),
                  )
                ],
              ),
            ),
    );
  }
}
