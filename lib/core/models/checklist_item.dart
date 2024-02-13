class ChecklistItem {
  final String name;
  bool value;

  ChecklistItem({required this.name, required this.value});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "value": value,
    };
  }

  factory ChecklistItem.fromMap(Map<String, dynamic> map) {
    return ChecklistItem(
      name: map["name"],
      value: map["value"],
    );
  }
}
