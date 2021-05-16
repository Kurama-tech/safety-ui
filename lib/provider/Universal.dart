import 'package:flutter/material.dart';

import 'package:safety/models/Models.dart';

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
    }
    notifyListeners();
  }
}

class Places with ChangeNotifier {
  List<UnversalModel> data;
  
  bool flag = false;
  bool noData = false;
  
  setData(dbData) {
    data = dbData;
    flag = true;
    if (dbData.length < 1) {
      noData = true;
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
    }
    notifyListeners();
  }
}
