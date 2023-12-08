import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:welcome_todo/signinpages/buttons.dart';
import 'package:welcome_todo/signinpages/mytextfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final conformpassword = TextEditingController();

//sign user up
  Future<void> signup() async {
    //
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    //make sure password match
    if (passwordTextController.text != conformpassword.text) {
      //pop loading circle
      Navigator.pop(context);
      //show error message
      displayMessage("password don't match!");
      return;
    }
    //try creating the user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading ciercle
      Navigator.pop(context);
      //show error to user
      displayMessage(e.code);
    }
  }

  //display a dialog message
  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child:SingleChildScrollView (
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
        
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
        
                const SizedBox(height: 50),
        
                // welcome back, you've been missed!
                Text(
                  'create an acoount',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
        
                const SizedBox(height: 25),
        
                // email textfield
                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false,
                ),
        
                const SizedBox(height: 10),
        
                // password textfield
                MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obscureText: true,
                ),
        
                const SizedBox(height: 10),
        
                MyTextField(
                  controller: conformpassword,
                  hintText: 'Conform password',
                  obscureText: true,
                ),
        
                const SizedBox(height: 10),
        
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(height: 25),
        
                // sign in button
                MyButton(onTap: signup, text: 'sign Up'),
        
                const SizedBox(height: 50),
        
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(height: 50),
        
                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    // SquareTile(imagePath: 'lib/images/google.png'),
        
                    SizedBox(width: 25),
        
                    // apple button
                    // SquareTile(imagePath: 'lib/images/apple.png')
                  ],
                ),
        
                const SizedBox(height: 50),
        
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
