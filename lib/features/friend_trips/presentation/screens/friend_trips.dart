import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_checklist/core/change_notifier/friend_trips_access.dart';
import 'package:travel_checklist/core/models/email_access.dart';

import 'friend_trip_checklist.dart';

class FriendTrips extends StatefulWidget {
  const FriendTrips({super.key});

  @override
  State<FriendTrips> createState() => _FriendTripsState();
}

class _FriendTripsState extends State<FriendTrips> {
  List<EmailAccess> emailAccess = [];

  @override
  void initState() {
    super.initState();
    emailAccess = context.read<FriendTripsAccess>().emailAccess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friend Trips"),
      ),
      body: SafeArea(
        child: emailAccess.isNotEmpty
            ? ListView.builder(
                itemCount: emailAccess.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: Text(
                      (i + 1).toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    title: Text(emailAccess[i].doc),
                    subtitle: Text("owner: ${emailAccess[i].mail}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return FriendTripChecklist(
                              emailAccess: emailAccess[i],
                            );
                          },
                        ),
                      );
                    },
                  );
                })
            : const Center(
                child: Text(
                  "No Trips Here!",
                  style: TextStyle(fontSize: 18),
                ),
              ),
      ),
    );
  }
}
