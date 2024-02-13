import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/change_notifier/trip_checklist_change_notifier.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';
import 'package:travel_checklist/features/share_access/presentation/share_access.dart';
import 'package:travel_checklist/features/trip_page/bloc/trip_page_bloc.dart';
import 'package:travel_checklist/features/trip_page/presentation/widgets/category_list.dart';
import 'package:travel_checklist/features/trip_page/presentation/widgets/custom_alert_dialog.dart';

class TripPage extends StatefulWidget {
  final int index;

  const TripPage({
    super.key,
    required this.index,
  });

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  List<TripChecklist> list = [];

  @override
  void initState() {
    super.initState();
    list = context.read<TripChecklistChangeNotifier>().list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(list[widget.index].name),
      ),
      body: SafeArea(
        child: BlocConsumer<TripPageBloc, TripPageState>(
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
                  return CustomAlertDialog(
                    list: list,
                    index: widget.index,
                  );
                },
              );
            }
            if (state is UpdateList) {
              list = state.list;
              context
                  .read<TripChecklistChangeNotifier>()
                  .updateList(state.list);
            }
          },
          builder: (context, state) {
            if (state is TripPageLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Is this checklist public?"),
                      Switch(
                        value: list[widget.index].public,
                        onChanged: (value) {
                          context.read<TripPageBloc>().add(
                                PublicUpdated(
                                  list,
                                  widget.index,
                                  value
                                ),
                              );
                        },
                      )
                    ],
                  ),
                  if(list[widget.index].public)
                    ListTile(
                      title: const Text("Share Access to this trip"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context){
                            return ShareAccess(
                                index:widget.index,
                            );
                          }),
                        );
                      },
                    ),
                  ListTile(
                    title: const Text("New Category"),
                    trailing: const Icon(Icons.add),
                    onTap: () {
                      context.read<TripPageBloc>().add(NewEventButtonClicked());
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: list[widget.index].data.length,
                      itemBuilder: (context, itr) {
                        return CategoryList(
                          index: widget.index,
                          categoryIndex: itr,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
