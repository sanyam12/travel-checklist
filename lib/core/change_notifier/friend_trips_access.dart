import 'package:flutter/cupertino.dart';
import 'package:travel_checklist/core/models/email_access.dart';

class FriendTripsAccess extends ChangeNotifier{
  List<EmailAccess> _emailAccess = [];
  List<EmailAccess> get emailAccess => _emailAccess;
  void updateList(List<EmailAccess> newList){
    _emailAccess = newList;
    notifyListeners();
  }
}