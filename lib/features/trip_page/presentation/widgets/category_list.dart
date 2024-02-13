import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/change_notifier/trip_checklist_change_notifier.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';
import 'package:travel_checklist/features/trip_page/bloc/trip_page_bloc.dart';

class CategoryList extends StatefulWidget {
  final int index;
  final int categoryIndex;

  const CategoryList({
    super.key,
    required this.index,
    required this.categoryIndex,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<TripChecklist> list = [];
  final itemNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    list = context.read<TripChecklistChangeNotifier>().list;
  }

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
                    context.read<TripPageBloc>().add(NewItemCreated(
                          index: widget.index,
                          categoryIndex: widget.categoryIndex,
                          itemName: itemNameController.text,
                          list: list,
                        ));
                    itemNameController.text = "";
                    Navigator.pop(context);
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
    final itemList = list[widget.index].data[widget.categoryIndex].list;
    return BlocListener<TripPageBloc, TripPageState>(
      listener: (context, state) {},
      child: ExpansionTile(
        leading: Text(
          (widget.categoryIndex + 1).toString(),
          style: const TextStyle(fontSize: 16),
        ),
        title: Text(
          list[widget.index].data[widget.categoryIndex].title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        children: [
          ListTile(
            title: const Text("New Item"),
            trailing: const Icon(Icons.add),
            onTap: () {
              _showDialog();
            },
          ),
          for (int i = 0; i < itemList.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(itemList[i].name),
                Checkbox(
                  value: itemList[i].value,
                  onChanged: (value) {
                    context.read<TripPageBloc>().add(
                          ItemValueUpdated(
                            list: list,
                            index: widget.index,
                            value: value ?? false,
                            categoryIndex: widget.categoryIndex,
                            itemIndex: i,
                          ),
                        );
                  },
                )
              ],
            )
        ],
      ),
    );
  }
}
