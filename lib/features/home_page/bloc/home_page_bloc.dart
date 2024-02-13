import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/models/email_access.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final FirebaseFirestore db;
  HomePageBloc(this.db) : super(HomePageInitial()) {
    on<NewTripButtonClicked>(_onNewTripButtonClicked);
    on<NewTripAdded>(_onNewTripAdded);
    on<FetchAllTrips>(_onFetchAllTrips);
    on<FetchFriendTrips>(_onFetchFriendTrips);
  }

  _onNewTripButtonClicked(
    NewTripButtonClicked event,
    Emitter<HomePageState> emit,
  ) {
    emit(ShowPopUp());
    emit(HomePageInitial());
  }

  _onNewTripAdded(
    NewTripAdded event,
    Emitter<HomePageState> emit,
  ) async {
    emit(HomePageLoading());
    try {
      if(event.tripName=="partner"){
        throw Exception("partner cannot be used as a trip name. sorry for inconvenience");
      }
      final email = FirebaseAuth.instance.currentUser?.email ?? "";
      final ref = db.collection(email).doc(event.tripName);
      //TODO: check if already existing
      final newChecklist = TripChecklist(
        public: event.public,
        name: event.tripName,
        data: [],
        access: [],
      );
      await ref.set(
        newChecklist.toMap(),
      );
      final list = [...event.list, newChecklist];
      emit(UpdateList(list));
    } catch (e) {
      emit(ShowSnackbar(e.toString()));
    }
  }

  _onFetchAllTrips(
    FetchAllTrips event,
    Emitter<HomePageState> emit,
  ) async {
    // try {
      final email = FirebaseAuth.instance.currentUser?.email ?? "";
      final data = await db.collection(email).get();
      final docs = data.docs;
      final list = <TripChecklist>[];
      for (var i in docs) {
        if(i.id!="partner"){
          final data = i.data();
          final instance = TripChecklist.fromMap(data);
          list.add(instance);
        }
      }
      emit(UpdateList(list));
    // } catch (e) {
    //   emit(ShowSnackbar(e.toString()));
    // }
  }

  _onFetchFriendTrips(
      FetchFriendTrips event,
      Emitter<HomePageState> emit,
  ) async {
    emit(HomePageLoading());
    try{
      final email = FirebaseAuth.instance.currentUser?.email??"";

      final response = await db.collection(email).doc("partner").get();
      final json = response.data()??{};
      final list = ((json["list"]??[]) as List).map((e) => EmailAccess.fromMap(e)).toList();
      emit(UpdateFriendList(list));

    } catch(e){
      emit(ShowSnackbar(e.toString()));
    }
  }

}
