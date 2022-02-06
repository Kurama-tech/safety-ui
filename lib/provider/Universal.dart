import 'package:flutter/material.dart';

import 'package:my_safety/models/Models.dart';

class UniversalProvider with ChangeNotifier {
  List<UnversalModel> data;
  List<Contacts> contacts;
  bool flag = false;
  bool noData = false;
  bool isContact = false;
  setData(dbData, isContact) {
    if (isContact) {
      contacts = dbData;
      isContact = isContact;
    } else {
      data = dbData;
    }
    flag = true;
    if (dbData.length < 1) {
      noData = true;
    }
    notifyListeners();
  }
}

class Warning with ChangeNotifier {
  List<UnversalModel> data;

  bool flag = false;
  bool noData = false;

  setData(dbData) {
    data = dbData;
    flag = true;
    if (dbData.length < 1) {
      noData = true;
      data = null;
      flag = false;
    }
    notifyListeners();
  }
}

class Coping with ChangeNotifier {
  List<UnversalModel> data;

  bool flag = false;
  bool noData = false;

  setData(dbData) {
    data = dbData;
    flag = true;
    if (dbData.length < 1) {
      noData = true;
      data = null;
      flag = false;
    }
    notifyListeners();
  }
}

class Reasons with ChangeNotifier {
  List<UnversalModel> data;

  bool flag = false;
  bool noData = false;

  setData(dbData) {
    data = dbData;
    flag = true;
    if (dbData.length < 1) {
      noData = true;
      data = null;
      flag = false;
    }
    notifyListeners();
  }
}

class Places with ChangeNotifier {
  List<PlacesModel> data;

  bool flag = false;
  bool noData = false;

  setData(dbData) {
    data = dbData;
    flag = true;
    if (dbData.length < 1) {
      noData = true;
      data = null;
      flag = false;
    }
    notifyListeners();
  }
}

class Notes with ChangeNotifier {
  List<UnversalModel> data;

  bool flag = false;
  bool noData = false;

  setData(dbData) {
    data = dbData;
    flag = true;
    if (dbData.length < 1) {
      noData = true;
      data = null;
      flag = false;
    }
    notifyListeners();
  }
}

class ContactsP with ChangeNotifier {
  List<Contacts> data;

  bool flag = false;
  bool noData = false;

  setData(dbData) {
    data = dbData;
    flag = true;
    if (dbData.length < 1) {
      noData = true;
      data = null;
      flag = false;
    }
    notifyListeners();
  }
}

class ContactsPP with ChangeNotifier {
  List<Contacts> data;

  bool flag = false;
  bool noData = false;

  setData(dbData) {
    data = dbData;
    flag = true;
    if (dbData.length < 1) {
      noData = true;
      data = null;
      flag = false;
    }
    notifyListeners();
  }
}

class Environments with ChangeNotifier {
  List<UnversalModel> data;

  bool flag = false;
  bool noData = false;

  setData(dbData) {
    data = dbData;
    flag = true;
    if (dbData.length < 1) {
      noData = true;
      data = null;
      flag = false;
    }
    notifyListeners();
  }
}

class AppointmentsP with ChangeNotifier {
  List<AppointmentsModel> data;
  bool flag = false;
  bool noData = true;
  setData(dbData) {
    data = dbData;
    flag = true;
    print(dbData.length);
    if (dbData.length >= 1) {
      noData = false;
    } else {
      noData = true;
      flag = false;
    }
    notifyListeners();
  }
}

class MedicationsP with ChangeNotifier {
  List<MedicationsModel> data;
  bool flag = false;
  bool noData = false;
  setData(dbData) {
    data = dbData;
    flag = true;
    if (dbData.length < 1) {
      noData = true;
      data = null;
      flag = false;
    }
    notifyListeners();
  }
}
