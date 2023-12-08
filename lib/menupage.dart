import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:welcome_todo/signinpages/Auth_page.dart';


class SignOutPage extends StatelessWidget {
  Future<void> signOut() async {
    try {
      // Check if there's a user signed in
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // User is signed in, proceed with sign-out
        await FirebaseAuth.instance.signOut();
        print("User signed out successfully");
      } else {
        // No user is signed in
        print("No user signed in");
      }
    } catch (e) {
      // Handle sign-out errors
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call the signOut method when the button is pressed
            signOut();
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AuthPage()),
  );
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: SignOutPage(),
//   ));
// }

