part of 'splash_screen_bloc.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();
}

class CheckIfSignedIn extends SplashScreenEvent{
  @override
  List<Object?> get props => [];
}
