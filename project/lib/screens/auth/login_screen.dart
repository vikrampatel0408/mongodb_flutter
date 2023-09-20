import 'package:flutter/material.dart';
import 'package:project/providers/auth_provider.dart';
import 'package:project/screens/auth/signup_screen.dart';
import 'package:provider/provider.dart';
import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Define controllers for the text fields
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void _showErrorDialog(String errorMessage) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }

    Future<void> _login() async {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      try {
        // Call the login method from the authProvider
        await authProvider.login(email, password);

        // Check if the user is not null in the authProvider
        final user = authProvider.user;
        if (user != null) {
          // If user is not null, navigate to HomeScreen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          // Handle the case where the login didn't set the user in the authProvider
          _showErrorDialog('Login failed. Please check your credentials.');
        }
      } catch (error) {
        _showErrorDialog(error.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: Text('Log In'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
                },
                child: Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
