import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/models/email_access.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';

part 'share_access_event.dart';

part 'share_access_state.dart';

class ShareAccessBloc extends Bloc<ShareAccessEvent, ShareAccessState> {
  final FirebaseFirestore db;
  ShareAccessBloc(this.db) : super(ShareAccessInitial()) {
    on<NewEmailButtonClicked>(_onNewEmailButtonClicked);
    on<NewEmailAdded>(_onNewEmailAdded);
    on<DeleteEmail>(_onDeleteEmail);
  }

  _onNewEmailButtonClicked(
    NewEmailButtonClicked event,
    Emitter<ShareAccessState> emit,
  ) {
    emit(ShowPopUp());
    emit(ShareAccessInitial());
  }

  _onNewEmailAdded(
    NewEmailAdded event,
    Emitter<ShareAccessState> emit,
  ) async {
    emit(ShareAccessLoading());
    try {
      final email = FirebaseAuth.instance.currentUser?.email ?? "";

      final newList = event.list;
      newList[event.index].access.add(event.email);

      db
          .collection(email)
          .doc(newList[event.index].name)
          .set(newList[event.index].toMap());

      final response = await db.collection(event.email).doc("partner").get();

      final Map<String, dynamic> data = response.data() ?? {};
      final temp = data["list"] ?? [];

      final list = temp.map((e) => EmailAccess.fromMap(e)).toList();
      list.add(EmailAccess(mail: email, doc: newList[event.index].name));

      await db.collection(event.email).doc("partner").set({
        "list": list.map((e) => e.toMap()).toList(),
      });

      emit(UpdateList(newList));
    } catch (e) {
      emit(ShowSnackbar(e.toString()));
    }
  }

  _onDeleteEmail(
    DeleteEmail event,
    Emitter<ShareAccessState> emit,
  ) async {
    emit(ShareAccessLoading());
    try {
      final email = FirebaseAuth.instance.currentUser?.email ?? "";

      final newList = event.list;
      newList[event.index]
          .access
          .removeWhere((element) => element == event.email);
      db
          .collection(email)
          .doc(newList[event.index].name)
          .set(newList[event.index].toMap());

      final response = await db.collection(event.email).doc("partner").get();

      final Map<String, dynamic> data = response.data() ?? {};
      final temp = data["list"] ?? [];
      final list = temp.map((e) => EmailAccess.fromMap(e)).toList();

      list.removeWhere((element) =>
          element.doc == newList[event.index].name && element.mail == email);

      await db.collection(event.email).doc("partner").set({
        "list": list.map((e) => e.toMap()).toList(),
      });


      emit(UpdateList(newList));
    } catch (e) {
      emit(ShowSnackbar(e.toString()));
    }
  }
}
