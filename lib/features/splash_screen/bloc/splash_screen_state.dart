part of 'splash_screen_bloc.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();
}

class SplashScreenInitial extends SplashScreenState {
  @override
  List<Object> get props => [];
}

class NavigateToHomePage extends SplashScreenState{
  @override
  List<Object?> get props => [];
}

class NavigateToSignInPage extends SplashScreenState{
  @override
  List<Object?> get props => [];
}