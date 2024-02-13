import 'package:travel_checklist/core/models/checklist_item.dart';

class ChecklistCategory{
  final String title;
  final List<ChecklistItem> list;

  ChecklistCategory({required this.title, required this.list});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "list": list.map((e) => e.toMap()).toList(),
    };
  }

  factory ChecklistCategory.fromMap(Map<String, dynamic> map){
    final list = (map["list"] as List).map((e) => ChecklistItem.fromMap(e)).toList();
    return ChecklistCategory(
        title: map["title"],
        list: list,
    );
  }
}