import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/models/email_access.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';
import 'package:travel_checklist/features/friend_trips/bloc/friend_trip_bloc.dart';

class CustomFriendAlertDialog extends StatefulWidget {
  final EmailAccess emailAccess;
  final TripChecklist checklist;

  const CustomFriendAlertDialog({
    super.key,
    required this.emailAccess,
    required this.checklist,
  });

  @override
  State<CustomFriendAlertDialog> createState() => _CustomFriendAlertDialogState();
}

class _CustomFriendAlertDialogState extends State<CustomFriendAlertDialog> {
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: const Text("Want to create new category?"),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Category Name"),
              ),
            ],
          ),
          actions: [
          ],
        ),
      ),
    );
  }
}