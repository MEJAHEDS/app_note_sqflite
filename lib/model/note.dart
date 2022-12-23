class Note {
  final String note;
  final int id;
  const Note({
    required this.id,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    final map = {
      "id": this.id,
      "note": this.note,
    };

    return map;
  }

  @override
  String toString() {
    return '$note';
  }
}
