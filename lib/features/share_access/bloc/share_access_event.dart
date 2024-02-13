part of 'share_access_bloc.dart';

abstract class ShareAccessEvent extends Equatable {
  const ShareAccessEvent();
}

class NewEmailButtonClicked extends ShareAccessEvent {
  @override
  List<Object?> get props => [];
}

class NewEmailAdded extends ShareAccessEvent {
  final String email;
  final List<TripChecklist> list;
  final int index;

  const NewEmailAdded(
    this.email,
    this.list,
    this.index,
  );

  @override
  List<Object?> get props => [email, list, index];
}

class DeleteEmail extends ShareAccessEvent {
  final String email;
  final int index;
  final List<TripChecklist> list;

  const DeleteEmail(this.email, this.index, this.list);

  @override
  List<Object?> get props => throw UnimplementedError();

}