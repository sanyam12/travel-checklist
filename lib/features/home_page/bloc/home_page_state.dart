part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageInitial extends HomePageState {
  @override
  List<Object> get props => [];
}

class ShowPopUp extends HomePageState{
  @override
  List<Object?> get props => [];

}

class HomePageLoading extends HomePageState{
  @override
  List<Object?> get props => [];
}

class ShowSnackbar extends HomePageState{
  final String message;

  const ShowSnackbar(this.message);

  @override
  List<Object?> get props => [message];

}

class UpdateList extends HomePageState{
  final List<TripChecklist> list;

  const UpdateList(this.list);

  @override
  List<Object?> get props => [];

}

class UpdateFriendList extends HomePageState{
  final List<EmailAccess> list;

  const UpdateFriendList(this.list);

  @override
  List<Object?> get props => [];


}