part of 'friend_trip_bloc.dart';

abstract class FriendTripEvent extends Equatable {
  const FriendTripEvent();
}

class FetchTripChecklist extends FriendTripEvent {
  final EmailAccess emailAccess;

  const FetchTripChecklist(this.emailAccess);

  @override
  List<Object?> get props => [];
}