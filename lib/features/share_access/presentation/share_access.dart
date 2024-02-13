import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/change_notifier/trip_checklist_change_notifier.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';
import 'package:travel_checklist/features/share_access/bloc/share_access_bloc.dart';

class ShareAccess extends StatefulWidget {
  final int index;

  const ShareAccess({super.key, required this.index});

  @override
  State<ShareAccess> createState() => _ShareAccessState();
}

class _ShareAccessState extends State<ShareAccess> {
  List<TripChecklist> list = [];
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    list = context.read<TripChecklistChangeNotifier>().list;
  }

  _showPopUp() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Email ID"),
          content: TextField(
            controller: emailController,
            decoration: const InputDecoration(hintText: "Enter Email ID"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                context.read<ShareAccessBloc>().add(
                      NewEmailAdded(
                        emailController.text,
                        list,
                        widget.index,
                      ),
                    );
                Navigator.pop(context);
              },
              child: const Text("Add Email"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Access: ${list[widget.index].name}"),
      ),
      body: SafeArea(
        child: BlocConsumer<ShareAccessBloc, ShareAccessState>(
          listener: (context, state) {
            if (state is ShowPopUp) {
              _showPopUp();
            }
            if (state is UpdateList) {
              context
                  .read<TripChecklistChangeNotifier>()
                  .updateList(state.list);
            }
          },
          builder: (context, state) {
            if (state is ShareAccessLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                const ListTile(
                  title: Text("People with Access are:"),
                ),
                ListTile(
                  title: const Text("New Email"),
                  trailing: const Icon(Icons.add),
                  onTap: () {
                    context
                        .read<ShareAccessBloc>()
                        .add(NewEmailButtonClicked());
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: list[widget.index].access.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(list[widget.index].access[i]),
                        trailing: const Icon(Icons.delete),
                        onTap: () {
                          context.read<ShareAccessBloc>().add(
                                DeleteEmail(
                                  list[widget.index].access[i],
                                  widget.index,
                                  list,
                                ),
                              );
                        },
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
