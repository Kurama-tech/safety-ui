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
    return {'id': id, 'name': name, 'number': number};
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Contacts{id: $id, name: $name, number: $number}';
  }
}

class AppointmentsModel {
  final int id;
  final String docName;
  final String dateTime;

  AppointmentsModel({this.id, this.docName, this.dateTime});
  Map<String, dynamic> toMap(){
    return {'id': id, 'docName': docName, 'Date': dateTime};
  }
}

class MedicationsModel {
  final int id;
  final String tabName;
  final String dateTime;

  MedicationsModel({this.id, this.tabName, this.dateTime});
  Map<String, dynamic> toMap(){
    return {'id': id, 'docName': tabName, 'Date': dateTime};
  }
}
