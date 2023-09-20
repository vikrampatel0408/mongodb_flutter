import 'package:flutter/material.dart';
import 'package:project/providers/auth_provider.dart';
import 'package:project/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
              authProvider.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${authProvider.user!.name}!'),
            // Add your home screen content here
          ],
        ),
      ),
    );
  }
}
