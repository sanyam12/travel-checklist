import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:travel_checklist/core/change_notifier/friend_trips_access.dart';
import 'package:travel_checklist/core/change_notifier/trip_checklist_change_notifier.dart';
import 'package:travel_checklist/features/friend_trips/bloc/friend_trip_bloc.dart';
import 'package:travel_checklist/features/home_page/bloc/home_page_bloc.dart';
import 'package:travel_checklist/features/home_page/presentation/screens/home_page.dart';
import 'package:travel_checklist/features/share_access/bloc/share_access_bloc.dart';
import 'package:travel_checklist/features/sign_in/presentation/google_sign_in_page.dart';
import 'package:travel_checklist/features/splash_screen/bloc/splash_screen_bloc.dart';
import 'package:travel_checklist/features/splash_screen/presentation/screens/splash_screen.dart';
import 'package:travel_checklist/features/trip_page/bloc/trip_page_bloc.dart';
import 'package:travel_checklist/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) {
        final db = FirebaseFirestore.instance;
        final email = FirebaseAuth.instance.currentUser?.email??"";
        db.settings = const Settings(persistenceEnabled: true);
        db.enableNetwork();
        return db;
      },
      child: ChangeNotifierProvider(
        create: (context)=>FriendTripsAccess(),
        child: ChangeNotifierProvider(
          create: (context) => TripChecklistChangeNotifier(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SplashScreenBloc(),
              ),
              BlocProvider(
                create: (context) => HomePageBloc(context.read<FirebaseFirestore>()),
              ),
              BlocProvider(
                create: (context) => TripPageBloc(context.read<FirebaseFirestore>()),
              ),
              BlocProvider(
                create: (context) => ShareAccessBloc(context.read<FirebaseFirestore>()),
              ),
              BlocProvider(
                  create: (context)=> FriendTripBloc(context.read<FirebaseFirestore>()),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              initialRoute: "/splash_screen",
              routes: {
                "/home": (context) => const HomePage(),
                "/sign_in": (context) => const GoogleSignInPage(),
                "/splash_screen": (context) => const SplashScreen(),
              },
            ),
          ),
        ),
      ),
    );
  }
}
