import 'package:flutter/cupertino.dart';
import 'package:travel_checklist/core/models/trip_checklist.dart';

class TripChecklistChangeNotifier extends ChangeNotifier{
  List<TripChecklist> _list = [];
  List<TripChecklist> get list => _list;
  void updateList(List<TripChecklist> newList){
    _list = newList;
    notifyListeners();
  }
}