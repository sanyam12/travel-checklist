import 'package:travel_checklist/core/models/checklist_category.dart';
import 'package:travel_checklist/core/models/email_access.dart';

class TripChecklist {
  bool public;
  final String name;
  final List<ChecklistCategory> data;
  final List<String> access;

  TripChecklist({
    required this.public,
    required this.name,
    required this.data,
    required this.access,
  });

  Map<String, dynamic> toMap() {
    return {
      'public': public,
      'name': name,
      "data": data.map((element) {
        return element.toMap();
      }).toList(),
      "access":access,
    };
  }

  factory TripChecklist.fromMap(Map<String, dynamic> map) {
    final data =
        (map["data"] as List).map((e) => ChecklistCategory.fromMap(e)).toList();
    final list = (map["access"] as List);
    final access = list.map((e) => e.toString()).toList();
    return TripChecklist(
      public: map["public"],
      name: map["name"],
      data: data,
      access: access,
    );
  }
}
