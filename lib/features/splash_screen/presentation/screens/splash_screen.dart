import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/features/splash_screen/bloc/splash_screen_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    context.read<SplashScreenBloc>().add(CheckIfSignedIn());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SplashScreenBloc, SplashScreenState>(
          listener: (context, state) {
            if(state is NavigateToHomePage){
              Navigator.of(context).popAndPushNamed("/home");
            }
            if(state is NavigateToSignInPage){
              Navigator.of(context).popAndPushNamed("/sign_in");
            }
          },
          child: const Center(child: Icon(Icons.people, size: 120,))
        ),
      ),
    );
  }
}
