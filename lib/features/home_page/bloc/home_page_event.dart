part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class NewTripButtonClicked extends HomePageEvent {
  @override
  List<Object?> get props => [];
}

class NewTripAdded extends HomePageEvent {
  final String tripName;
  final bool public;
  final List<TripChecklist> list;

  const NewTripAdded({
    required this.tripName,
    required this.public,
    required this.list,
  });

  @override
  List<Object?> get props => [];
}

class FetchAllTrips extends HomePageEvent {
  @override
  List<Object?> get props => [];
}

class FetchFriendTrips extends HomePageEvent{
  @override
  List<Object?> get props => [];

}
