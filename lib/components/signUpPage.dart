import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpPage({
    super.key,
    required this.onClickedSignIn,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? "Enter a valid email"
                    : null,
          ),
          const SizedBox(
            height: 4,
          ),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != null && value.length < 6
                ? "Enter min. 6 characters"
                : null,
          ),
          TextFormField(
            controller: usernameController,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Username'),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != null && value.length < 3
                ? "Enter min. 3 characters"
                : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const Icon(Icons.email, size: 32),
            label: const Text(
              'Sign up',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () => {
              signUp(),
            },
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
              ),
              text: "Already have an account? ",
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignIn,
                  text: "Log In",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    FirebaseAuth.instance.currentUser!.updateDisplayName(
      usernameController.text.trim(),
    );
  }
}
