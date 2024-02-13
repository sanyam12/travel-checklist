part of 'share_access_bloc.dart';

abstract class ShareAccessState extends Equatable {
  const ShareAccessState();
}

class ShareAccessInitial extends ShareAccessState {
  @override
  List<Object> get props => [];
}

class ShareAccessLoading extends ShareAccessState{
  @override
  List<Object?> get props => [];
}

class ShowPopUp extends ShareAccessState{
  @override
  List<Object?> get props => [];

}

class UpdateList extends ShareAccessState{
  final List<TripChecklist> list;

  const UpdateList(this.list);

  @override
  List<Object?> get props => [list];

}

class ShowSnackbar extends ShareAccessState{
  final String message;

  const ShowSnackbar(this.message);

  @override
  List<Object?> get props => [message];

}