part of 'trip_page_bloc.dart';

abstract class TripPageState extends Equatable {
  const TripPageState();
}

class TripPageInitial extends TripPageState {
  @override
  List<Object> get props => [];
}

class ShowPopUp extends TripPageState{
  @override
  List<Object?> get props => [];

}

class TripPageLoading extends TripPageState{
  @override
  List<Object?> get props => [];

}

class ShowSnackbar extends TripPageState{
  final String message;

  const ShowSnackbar(this.message);

  @override
  List<Object?> get props => [message];

}

class UpdateList extends TripPageState{
  final List<TripChecklist> list;

  const UpdateList(this.list);

  @override
  List<Object?> get props => [list];

}
