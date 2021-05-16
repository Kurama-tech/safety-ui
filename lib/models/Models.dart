class UnversalModel {
  final int id;
  final String statergy;

  UnversalModel({this.id, this.statergy});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'statergy': statergy,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'UnversalModel{id: $id, statergy: $statergy}';
  }
}

class Contacts {
  final int id;
  final String name;
  final int number;

  Contacts({this.id, this.name, this.number});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Contacts{id: $id, name: $name, number: $number}';
  }
}
