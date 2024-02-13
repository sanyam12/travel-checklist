part of 'friend_trip_bloc.dart';

abstract class FriendTripState extends Equatable {
  const FriendTripState();
}

class FriendTripInitial extends FriendTripState {
  @override
  List<Object> get props => [];
}

class FetchedChecklist extends FriendTripState{
  final TripChecklist checklist;

  const FetchedChecklist(this.checklist);

  @override
  List<Object?> get props => [];

}

class ShowSnackbar extends FriendTripState{
  final String message;

  const ShowSnackbar(this.message);

  @override
  List<Object?> get props => [message];

}

class ShowPopUp extends FriendTripState{
  @override
  List<Object?> get props => [];

}

class UpdateList extends FriendTripState{
  final TripChecklist checklist;

  const UpdateList(this.checklist);

  @override
  List<Object?> get props => [checklist];

}
