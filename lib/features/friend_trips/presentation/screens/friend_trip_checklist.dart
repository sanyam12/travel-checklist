import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/models/email_access.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';
import 'package:travel_checklist/features/friend_trips/bloc/friend_trip_bloc.dart';
import 'package:travel_checklist/features/friend_trips/presentation/widgets/friend_category_list.dart';

import '../widgets/custom_friend_alert_dialog.dart';

class FriendTripChecklist extends StatefulWidget {
  final EmailAccess emailAccess;

  const FriendTripChecklist({
    super.key,
    required this.emailAccess,
  });

  @override
  State<FriendTripChecklist> createState() => _FriendTripChecklistState();
}

class _FriendTripChecklistState extends State<FriendTripChecklist> {
  late final TripChecklist checklist;

  @override
  void initState() {
    super.initState();
    context.read<FriendTripBloc>().add(FetchTripChecklist(widget.emailAccess));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendTripBloc, FriendTripState>(
      listener: (context, state) {
        if (state is ShowSnackbar) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if (state is ShowPopUp) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomFriendAlertDialog(
                emailAccess: widget.emailAccess,
                checklist: checklist,
              );
            },
          );
        }
        if (state is ShowPopUp) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomFriendAlertDialog(
                emailAccess: widget.emailAccess,
                checklist: checklist,
              );
            },
          );
        }
      },
      builder: (context, state) {
        log(state.toString());
        if (state is FetchedChecklist) {
          checklist = state.checklist;
          return Scaffold(
            appBar: AppBar(
              title: Text("${checklist.name} (Read Only)"),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: checklist.data.length,
                        itemBuilder: (context, itr) {
                          // return Text(checklist.data[itr].title);
                          return FriendCategoryList(
                            checklist: checklist,
                            categoryIndex: itr,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
