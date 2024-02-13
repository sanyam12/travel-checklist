import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';
import 'package:travel_checklist/features/friend_trips/bloc/friend_trip_bloc.dart';

class FriendCategoryList extends StatefulWidget {
  final TripChecklist checklist;
  final int categoryIndex;

  const FriendCategoryList({
    super.key,
    required this.checklist,
    required this.categoryIndex,
  });

  @override
  State<FriendCategoryList> createState() => _FriendCategoryListState();
}

class _FriendCategoryListState extends State<FriendCategoryList> {
  final itemNameController = TextEditingController();

  _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: const Text("New Item Name"),
              content: Column(
                children: [
                  TextField(
                    controller: itemNameController,
                    decoration: const InputDecoration(
                      hintText: "Enter Item Name",
                    ),
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {

                  },
                  child: const Text("Create"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemList = widget.checklist.data[widget.categoryIndex].list;
    return BlocListener<FriendTripBloc, FriendTripState>(
      listener: (context, state) {},
      child: ExpansionTile(
        leading: Text(
          (widget.categoryIndex + 1).toString(),
          style: const TextStyle(fontSize: 16),
        ),
        title: Text(
          widget.checklist.data[widget.categoryIndex].title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        children: [
          for (int i = 0; i < itemList.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(itemList[i].name),
                Checkbox(
                  value: itemList[i].value,
                  onChanged: (value) {
                  },
                )
              ],
            )
        ],
      ),
    );
  }
}