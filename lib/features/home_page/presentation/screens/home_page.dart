import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_checklist/core/change_notifier/friend_trips_access.dart';
import 'package:travel_checklist/core/change_notifier/trip_checklist_change_notifier.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';
import 'package:travel_checklist/features/friend_trips/presentation/screens/friend_trips.dart';
import 'package:travel_checklist/features/home_page/bloc/home_page_bloc.dart';
import 'package:travel_checklist/features/home_page/presentation/widgets/alert_dialog.dart';
import 'package:travel_checklist/features/trip_page/presentation/screens/trip_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPublic = false;
  List<TripChecklist> list = [];

  @override
  void initState() {
    super.initState();
    context.read<HomePageBloc>().add(FetchAllTrips());
    context.read<HomePageBloc>().add(FetchFriendTrips());
    list = context.read<TripChecklistChangeNotifier>().list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check List"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.popAndPushNamed(context, "/sign_in");
              }
            },
            child: const Icon(Icons.power_off),
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<HomePageBloc, HomePageState>(
          listener: (context, state) {
            if (state is ShowPopUp) {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(
                    list: list,
                  );
                },
              );
            }
            if (state is ShowSnackbar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is UpdateList) {
              list = state.list;
              context
                  .read<TripChecklistChangeNotifier>()
                  .updateList(state.list);
            }
            if (state is UpdateFriendList) {
              context.read<FriendTripsAccess>().updateList(state.list);
            }
          },
          builder: (context, state) {
            if (state is HomePageLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                ListTile(
                  title: const Text("New Trip"),
                  trailing: const Icon(Icons.add),
                  onTap: () {
                    context.read<HomePageBloc>().add(NewTripButtonClicked());
                  },
                ),
                ListTile(
                  title: const Text("Friend's Trips"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const FriendTrips();
                    }));
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, itr) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(list[itr].name),
                            subtitle:
                                Text(list[itr].public ? "Public" : "Private"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return TripPage(
                                    index: itr,
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomePageBloc>().add(FetchAllTrips());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
