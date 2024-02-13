import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_checklist/firebase_options.dart';

class GoogleSignInPage extends StatelessWidget {
  const GoogleSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 58.0),
                child: Text(
                  "Welcome, Please Login to Continue",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await onPress(context);
                },
                child: const Text("Sign In"),
              )
            ],
          ),
        ),
      ),
    );
  }

  onPress(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final creds = await FirebaseAuth.instance.signInWithCredential(credential);

    if (creds.credential != null &&
        creds.credential?.token != null &&
        context.mounted) {
      Navigator.popAndPushNamed(context, "/home");
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to login, try again"),
        ),
      );
    }
  }
}
