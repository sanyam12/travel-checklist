class EmailAccess {
  final String mail;
  final String doc;

  EmailAccess({required this.mail, required this.doc});

  factory EmailAccess.fromMap(Map<String, dynamic> map) {
    return EmailAccess(
      mail: map["mail"],
      doc: map["doc"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "mail": mail,
      "doc": doc,
    };
  }
}
