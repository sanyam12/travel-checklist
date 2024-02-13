part of 'trip_page_bloc.dart';

abstract class TripPageEvent extends Equatable {
  const TripPageEvent();
}

class NewEventButtonClicked extends TripPageEvent {
  @override
  List<Object?> get props => [];
}

class NewEventCreated extends TripPageEvent {
  final String title;
  final int index;
  final List<TripChecklist> list;

  const NewEventCreated(
    this.title,
    this.list,
    this.index,
  );

  @override
  List<Object?> get props => [];
}

class NewItemCreated extends TripPageEvent {
  final int index;
  final int categoryIndex;
  final String itemName;
  final List<TripChecklist> list;

  NewItemCreated({
    required this.index,
    required this.categoryIndex,
    required this.itemName,
    required this.list,
  });

  @override
  List<Object?> get props => [];
}

class PublicUpdated extends TripPageEvent {
  final List<TripChecklist> list;
  final int index;
  final bool value;

  const PublicUpdated(
    this.list,
    this.index,
    this.value,
  );

  @override
  List<Object?> get props => [];
}

class ItemValueUpdated extends TripPageEvent {
  final List<TripChecklist> list;
  final int index;
  final bool value;
  final int categoryIndex;
  final int itemIndex;

  const ItemValueUpdated({
    required this.list,
    required this.index,
    required this.value,
    required this.categoryIndex,
    required this.itemIndex,
  });

  @override
  List<Object?> get props => [];
}
