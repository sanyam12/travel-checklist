import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';
import 'package:travel_checklist/features/trip_page/bloc/trip_page_bloc.dart';

class CustomAlertDialog extends StatefulWidget {
  final List<TripChecklist> list;
  final int index;

  const CustomAlertDialog({
    super.key,
    required this.list,
    required this.index,
  });

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
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
            ElevatedButton(
              onPressed: () {
                context.read<TripPageBloc>().add(
                      NewEventCreated(
                        titleController.text,
                        widget.list,
                        widget.index,
                      ),
                    );
                Navigator.pop(context);
              },
              child: const Text("Create"),
            )
          ],
        ),
      ),
    );
  }
}
