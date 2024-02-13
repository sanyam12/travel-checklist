import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';
import 'package:travel_checklist/features/home_page/bloc/home_page_bloc.dart';

class CustomAlertDialog extends StatefulWidget {
  final List<TripChecklist> list;
  const CustomAlertDialog({super.key, required this.list});

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  final nameController = TextEditingController();

  bool isPublic = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          scrollable: false,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Trip Name"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Keep Public?"),
                  Switch(
                    value: isPublic,
                    onChanged: (value) {
                      setState(() {
                        isPublic = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                context.read<HomePageBloc>().add(
                      NewTripAdded(
                        tripName: nameController.text,
                        public: isPublic,
                        list: widget.list,
                      ),
                    );
                Navigator.pop(context);
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
