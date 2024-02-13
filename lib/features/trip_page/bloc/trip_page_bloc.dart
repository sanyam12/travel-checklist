import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/models/checklist_category.dart';
import 'package:travel_checklist/core/models/checklist_item.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';

part 'trip_page_event.dart';

part 'trip_page_state.dart';

class TripPageBloc extends Bloc<TripPageEvent, TripPageState> {
  final FirebaseFirestore db;
  TripPageBloc(this.db) : super(TripPageInitial()) {
    on<NewEventButtonClicked>(_onNewEventButtonClicked);
    on<NewEventCreated>(_onNewCategoryCreated);
    on<NewItemCreated>(_onNewItemCreated);
    on<PublicUpdated>(_onPublicUpdated);
    on<ItemValueUpdated>(_onItemValueUpdated);
  }

  _onNewEventButtonClicked(
    NewEventButtonClicked event,
    Emitter<TripPageState> emit,
  ) {
    emit(ShowPopUp());
    emit(TripPageInitial());
  }

  _onNewCategoryCreated(
    NewEventCreated event,
    Emitter<TripPageState> emit,
  ) {
    emit(TripPageLoading());
    try {
      //TODO: Check for empty strings and other edge cases. same for home page and other routes.
      final email = FirebaseAuth.instance.currentUser?.email ?? "";

      final newList = event.list;
      newList[event.index].data.add(
            ChecklistCategory(
              title: event.title,
              list: [],
            ),
          );

      db.collection(email).doc(event.list[event.index].name).set(
            newList[event.index].toMap(),
          );
      emit(UpdateList(newList));
    } catch (e) {
      emit(ShowSnackbar(e.toString()));
    }
  }

  _onNewItemCreated(
    NewItemCreated event,
    Emitter<TripPageState> emit,
  ) {
    emit(TripPageLoading());
    try {
      final email = FirebaseAuth.instance.currentUser?.email ?? "";
      final newList = event.list;
      newList[event.index].data[event.categoryIndex].list.add(
            ChecklistItem(
              name: event.itemName,
              value: false,
            ),
          );
      db.collection(email).doc(event.list[event.index].name).set(
            newList[event.index].toMap(),
          );
      emit(UpdateList(newList));
    } catch (e) {
      emit(ShowSnackbar(e.toString()));
    }
  }

  _onPublicUpdated(
    PublicUpdated event,
    Emitter<TripPageState> emit,
  ) {
    try {
      final email = FirebaseAuth.instance.currentUser?.email ?? "";

      final newList = event.list;
      newList[event.index].public = event.value;
      db.collection(email).doc(newList[event.index].name).set(
            newList[event.index].toMap(),
          );
      emit(UpdateList(newList));
      emit(TripPageInitial());
    } catch (e) {
      emit(ShowSnackbar(e.toString()));
    }
  }

  _onItemValueUpdated(
      ItemValueUpdated event,
      Emitter<TripPageState> emit,
  ){
    try {
      final email = FirebaseAuth.instance.currentUser?.email ?? "";

      final newList = event.list;
      newList[event.index].data[event.categoryIndex].list[event.itemIndex]
          .value = event.value;
      db.collection(email).doc(newList[event.index].name).set(
        newList[event.index].toMap(),
      );
      emit(UpdateList(newList));
      emit(TripPageInitial());
    } catch (e) {
      emit(ShowSnackbar(e.toString()));
    }
  }

}
