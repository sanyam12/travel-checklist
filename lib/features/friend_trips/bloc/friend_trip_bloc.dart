import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/models/email_access.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';

part 'friend_trip_event.dart';

part 'friend_trip_state.dart';

class FriendTripBloc extends Bloc<FriendTripEvent, FriendTripState> {
  final FirebaseFirestore db;
  FriendTripBloc(this.db) : super(FriendTripInitial()) {
    on<FetchTripChecklist>(_onFetchTripChecklist);
  }

  _onFetchTripChecklist(event, emit) async {
    final email = event.emailAccess.mail;
    final response =
    await db.collection(email).doc(event.emailAccess.doc).get();
    final json = response.data() ?? {};
    final checklist = TripChecklist.fromMap(json);
    emit(FetchedChecklist(checklist));
  }
}
