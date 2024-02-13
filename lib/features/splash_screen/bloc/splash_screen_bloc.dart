import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'splash_screen_event.dart';

part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<CheckIfSignedIn>(_onCheckIfSignedIn);
  }

  _onCheckIfSignedIn(
    CheckIfSignedIn event,
    Emitter<SplashScreenState> emit,
  )async {
    await Future.delayed(const Duration(seconds: 2), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(NavigateToHomePage());
      } else {
        emit(NavigateToSignInPage());
      }
    });
  }
}
