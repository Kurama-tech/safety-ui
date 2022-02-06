import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_safety/databaseHandler.dart';
import 'package:my_safety/models/Models.dart';
import 'package:my_safety/provider/Universal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanningDetail extends StatefulWidget {
  PlanningDetail({Key key, this.title, this.description, this.table})
      : super(key: key);

  final String title;
  final String description;
  final String table;
  _PlanningState createState() => _PlanningState();
}

class _PlanningState extends State<PlanningDetail>
    with SingleTickerProviderStateMixin {
  DatabaseHandler dbhelper = DatabaseHandler();
  Database dbConnection;
  UnversalModel model = UnversalModel(id: 1, statergy: "hello");
  Contacts modelC = Contacts(id: 1, name: "Sawood", number: 8123303633);
  int itemCount = 0;
  int nextId = 0;
  bool isContactG = false;
  bool isPlacesG = false;
  bool noData = false;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    final dataProvider = getPerfectProvider(widget.table, false);
    bool isContact = widget.table == 'Contacts' ? true : false;
    bool isContactP = widget.table == 'ContactsP' ? true : false;
    bool isPlaces = this.widget.table == 'Places' ? true : false;
    dbhelper.onDbInit().then((database) {
      //dbhelper.insertUnversal(database, this.widget.table, model);
      //Rdbhelper.insertContact(database, this.widget.table, modelC);
      dbConnection = database;
      dbhelper.getLastID(database, this.widget.table).then((value) {
        print(widget.table);
        print(value);
        //print(isContact);
        isPlacesG = isPlaces;
        isContactG = isContact || isContactP;
        itemCount = value;
        nextId = itemCount + 1;

        if (isContact) {
          print('helloo ooo');
          dbhelper
              .getListDataContacts(database, this.widget.table)
              .then((value) {
            dataProvider.setData(value);
          });
        } else if (isContactP) {
          dbhelper
              .getListDataContacts(database, this.widget.table)
              .then((value) {
            dataProvider.setData(value);
          });
        } else if (isPlaces) {
          dbhelper.getListDataPlaces(database, this.widget.table).then((value) {
            dataProvider.setData(value);
          });
        } else {
          dbhelper.getListData(database, this.widget.table).then((value) {
            dataProvider.setData(value);
          });
        }
      });
    });

    super.initState();
  }

  commonInit(Database db, String table) {}

  getPerfectProvider(String table, bool listen) {
    switch (table) {
      case 'Warning':
        {
          return Provider.of<Warning>(context, listen: listen);
        }
        break;
      case 'Coping':
        {
          return Provider.of<Coping>(context, listen: listen);
        }
        break;
      case 'Reasons':
        {
          return Provider.of<Reasons>(context, listen: listen);
        }
        break;
      case 'Places':
        {
          return Provider.of<Places>(context, listen: listen);
        }
        break;
      case 'Notes':
        {
          return Provider.of<Notes>(context, listen: listen);
        }
        break;
      case 'Contacts':
        {
          return Provider.of<ContactsP>(context, listen: listen);
        }
        break;
      case 'ContactsP':
        {
          return Provider.of<ContactsPP>(context, listen: listen);
        }
        break;
      case 'Environment':
        {
          return Provider.of<Environments>(context, listen: listen);
        }
        break;
      default:
        {
          throw Error();
        }
        break;
    }
  }

  Widget noDataProgress(bool nodata) {
    final dataProvider = getPerfectProvider(this.widget.table, true);

    if (dataProvider.noData) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/3009286-ai.png",
                height: 300,
                width: 300,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.cyan[900])),
              onPressed: () {
                if (isContactG) {
                  _showMyDialogContacts(context, this.widget.title, false,
                      nextId, this.widget.table);
                } else if (isPlacesG) {
                  _showPlacesDialog(context, this.widget.title, false, nextId,
                      this.widget.table);
                } else {
                  _showMyDialog(context, this.widget.title, false, nextId,
                      this.widget.table);
                }
              },
              child: Text('Add ' + this.widget.title),
            ),
          )
        ],
      );
    }
    return Container(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final universalData = Provider.of<UniversalProvider>(context);
    final dataProvider = getPerfectProvider(this.widget.table, true);
    bool isContact = this.widget.table == 'Contacts' ? true : false;
    bool isContactP = this.widget.table == 'ContactsP' ? true : false;
    bool isPlaces = this.widget.table == 'Places' ? true : false;
    return Center(
        child: !dataProvider.flag
            ? noDataProgress(dataProvider.noData)
            : ListView(
                children: <Widget>[
                  universalBuild(
                      dataProvider, isContact || isContactP, isPlaces),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan[900])),
                      onPressed: () {
                        print("is contact" + isContact.toString());
                        print("is contact" + isContactP.toString());
                        if (isContact || isContactP) {
                          _showMyDialogContacts(context, this.widget.title,
                              false, nextId, this.widget.table);
                        } else if (isPlaces) {
                          _showPlacesDialog(context, this.widget.title, false,
                              nextId, this.widget.table);
                        } else {
                          _showMyDialog(context, this.widget.title, false,
                              nextId, this.widget.table);
                        }
                      },
                      child: Text('Add ' + this.widget.title),
                    ),
                  )
                ],
              ));
  }

  Widget perfectIcon(String title) {
    if (title == 'Warning Signs') {
      return Icon(
        Icons.warning,
        color: Colors.red[700],
        size: 40,
      );
    } else if (title == 'Places for Distraction') {
      return Icon(
        Icons.place,
        color: Color(0xFF3EB16F),
        size: 40,
      );
    }
    return Icon(
      Icons.star,
      color: Color(0xFF3EB16F),
      size: 40,
    );
  }

  Widget placesBuild(universalData) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: universalData.data.length,
        itemBuilder: (context, i) {
          final datalist = universalData.data[i];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 100,
            width: double.maxFinite,
            child: InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.grey,
              child: Card(
                elevation: 5,
                child: Center(
                  child: ListTile(
                    leading: Hero(
                        tag: datalist.id, child: perfectIcon(widget.title)),
                    title: Text(
                      datalist.statergy,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3EB16F),
                          fontWeight: FontWeight.w400),
                    ),
                    subtitle: Text(
                      datalist.landmark,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF3EB16F),
                      ),
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            _showPlacesDialog(context, this.widget.title, true,
                                datalist.id, this.widget.table, datalist);
                          },
                        ),
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              delete(context, this.widget.table, datalist.id,
                                  false, true);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () {},
            ),
          );
        });
  }

  Widget universalBuild(universalData, bool isContacts, bool isPlaces) {
    if (isContacts) {
      print("return Contacts");
      return contactsBuild(universalData);
    } else if (isPlaces) {
      print("places");
      return placesBuild(universalData);
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: universalData.data.length,
        itemBuilder: (context, i) {
          final datalist = universalData.data[i];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 100,
            width: double.maxFinite,
            child: InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.grey,
              child: Card(
                elevation: 5,
                child: Center(
                  child: ListTile(
                    leading: Hero(
                        tag: datalist.id, child: perfectIcon(widget.title)),
                    title: Text(
                      datalist.statergy,
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF3EB16F),
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            _showMyDialog(context, this.widget.title, true,
                                datalist.id, this.widget.table, datalist);
                          },
                        ),
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              delete(context, this.widget.table, datalist.id,
                                  false, isPlaces);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () {},
            ),
          );
        });
  }

  Widget contactsBuild(universalData) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: universalData.data.length,
        itemBuilder: (context, i) {
          final datalist = universalData.data[i];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            height: 100,
            child: InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.grey,
              child: Card(
                color: Colors.white,
                elevation: 5,
                child: Center(
                  child: ListTile(
                    leading: Hero(
                      tag: datalist.id,
                      child: Icon(
                        Icons.contact_phone,
                        color: Color(0xFF3EB16F),
                        size: 50,
                      ),
                    ),
                    title: Text(
                      datalist.name,
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF3EB16F),
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      datalist.number.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFC9C9C9),
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: editContactEnabled(datalist),
                  ),
                ),
              ),
              onTap: () {
                launch('tel:' + datalist.number.toString());
              },
            ),
          );
        });
  }

  Widget editContactEnabled(datalist) {
    if (datalist.id > 0) {
      return IconButton(
        icon: Icon(
          Icons.edit,
          color: Colors.cyan[900],
        ),
        onPressed: () {
          _showMyDialogContacts(context, this.widget.title, true, datalist.id,
              this.widget.table, datalist);
        },
      );
    }
    return null;
  }

  Future<void> _showMyDialog(
      BuildContext context, String title, bool isEditMode, int id, String table,
      [UnversalModel data]) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _statergyTextCtrl = TextEditingController();
    //_statergyTextCtrl.text = '';
    String addorEdit = 'Add ';
    if (isEditMode && data != null) {
      addorEdit = 'Edit ';
      _statergyTextCtrl.text = data.statergy;
    }

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        scrollable: true,
        title: Text(addorEdit + title),
        content: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _statergyTextCtrl,
                decoration: InputDecoration(
                  hintText: 'Enter ' + title,
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ],
          ),
        )),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            child: Text(addorEdit + title,
                style: TextStyle(color: (Colors.cyan[900]))),
            onPressed: () async {
              try {
                if (_formKey.currentState.validate()) {
                  var finaltext = _statergyTextCtrl.text;
                  final dataProvider = getPerfectProvider(widget.table, false);
                  UnversalModel model =
                      UnversalModel(id: id, statergy: finaltext);
                  if (isEditMode) {
                    await dbhelper
                        .updateUniversal(dbConnection, table, model)
                        .then((value) async {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(title + " " + addorEdit + "Successfull")));
                      await dbhelper
                          .getListData(dbConnection, table)
                          .then((value) {
                        dataProvider.setData(value);
                        Navigator.of(context).pop();
                      });
                    });
                  } else {
                    await dbhelper
                        .insertUnversal(dbConnection, table, model)
                        .then((value) async {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(title + " " + addorEdit + "Successfull")));
                      await dbhelper
                          .getListData(dbConnection, table)
                          .then((value) {
                        print(value.toString());
                        print(value.length == 0);
                        dataProvider.setData(value);
                        setState(() {
                          nextId = nextId + 1;
                          Navigator.of(context).pop();
                        });
                      });
                    });
                  }
                }
              } catch (err) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(err.toString())));
                throw new ErrorHint(err.toString());
              }
            },
          ),
          //deleteButtonWidget(context, isEditMode, table, id, false)
        ],
      ),
    );

    /* return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(addorEdit + title),
          content: SingleChildScrollView(
             child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _statergyTextCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter ' + title,
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ) 

              
          ),
          actions: <Widget>[
            TextButton(
              child: Text(addorEdit + title,
                  style: TextStyle(color: (Colors.cyan[900]))),
              onPressed: () async {
                try {
                  if (_formKey.currentState.validate()) {
                    var finaltext = _statergyTextCtrl.text;
                    final dataProvider =
                        getPerfectProvider(widget.table, false);
                    UnversalModel model =
                        UnversalModel(id: id, statergy: finaltext);
                    if (isEditMode) {
                      await dbhelper
                          .updateUniversal(dbConnection, table, model)
                          .then((value) async {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text(title + " " + addorEdit + "Successfull")));
                        await dbhelper
                            .getListData(dbConnection, table)
                            .then((value) {
                          dataProvider.setData(value);
                          Navigator.of(context).pop();
                        });
                      });
                    } else {
                      await dbhelper
                          .insertUnversal(dbConnection, table, model)
                          .then((value) async {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text(title + " " + addorEdit + "Successfull")));
                        await dbhelper
                            .getListData(dbConnection, table)
                            .then((value) {
                          print(value.toString());
                          print(value.length == 0);
                          dataProvider.setData(value);
                          setState(() {
                            nextId = nextId + 1;
                            Navigator.of(context).pop();
                          });
                        });
                      });
                    }
                  }
                } catch (err) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(err.toString())));
                  throw new ErrorHint(err.toString());
                }
              },
            ),
            TextButton.icon(
              label: Text(
                'Cancel',
                style: TextStyle(color: (Colors.red[900])),
              ),
              icon: Icon(
                Icons.cancel,
                color: Colors.red[900],
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            deleteButtonWidget(context, isEditMode, table, id, false)
          ],
        );
      },
    );*/
  }

  // ignore: missing_return
  Future<void> delete(BuildContext context, String table, int id,
      bool isContacts, bool isPlaces) {
    final dataProvider = getPerfectProvider(table, false);
    dbhelper.deleteUniversal(dbConnection, table, id).then((value) async {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Delete Successfull")));
      if (isContacts) {
        await dbhelper.getListDataContacts(dbConnection, table).then((value) {
          print("delete : " + value.toString());

          dataProvider.setData(value);
          print("delete : " + dataProvider.toString());

          nextId = nextId - 1;
          if (nextId < 0) {
            nextId = 0;
          }

          setState(() {});
        });
      } else if (isPlaces) {
        await dbhelper.getListDataPlaces(dbConnection, table).then((value) {
          dataProvider.setData(value);
          nextId = nextId - 1;
          if (nextId < 0) {
            nextId = 0;
          }

          setState(() {});
        });
      } else {
        await dbhelper.getListData(dbConnection, table).then((value) {
          dataProvider.setData(value);
          nextId = nextId - 1;
          if (nextId < 0) {
            nextId = 0;
          }

          setState(() {});
        });
      }
    });
  }

  Widget deleteButtonWidget(BuildContext context, bool showDelete, String table,
      int id, bool isContacts, bool isPlaces) {
    // final dataProvider = getPerfectProvider(table, false);
    if (showDelete && id > 0) {
      return IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () async {
          delete(context, table, id, isContacts, isPlaces);
          Navigator.of(context).pop();
        },
      );
    }
    return Text('');
  }

  Future<void> _showMyDialogContacts(
      BuildContext context, String title, bool isEditMode, int id, String table,
      [Contacts data]) async {
    String addorEdit = 'Add ';

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _nameTextCtrl = TextEditingController();
    TextEditingController _numberTextCtrl = TextEditingController();
    if (isEditMode && data != null) {
      addorEdit = 'Edit ';
      _nameTextCtrl.text = data.name;
      _numberTextCtrl.text = data.number.toString();
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(addorEdit + title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameTextCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter Name',
                        ),
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _numberTextCtrl,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        decoration: InputDecoration(
                          hintText: 'Enter Number',
                        ),
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length > 10 || value.length < 10) {
                            return 'Not a Valid Number';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                addorEdit + title,
                style: TextStyle(color: Color(0xFF3EB16F)),
              ),
              onPressed: () async {
                try {
                  if (_formKey.currentState.validate()) {
                    var name = _nameTextCtrl.text;
                    var number = _numberTextCtrl.text;
                    final dataProvider = getPerfectProvider(table, false);
                    Contacts model =
                        Contacts(id: id, name: name, number: int.parse(number));

                    if (isEditMode) {
                      await dbhelper
                          .updateContact(dbConnection, table, model)
                          .then((value) async {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text(title + " " + addorEdit + "Successfull")));
                        await dbhelper
                            .getListDataContacts(dbConnection, table)
                            .then((value) {
                          dataProvider.setData(value);
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        });
                      });
                    } else {
                      await dbhelper
                          .insertContact(dbConnection, table, model)
                          .then((value) async {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text(title + " " + addorEdit + "Successfull")));
                        await dbhelper
                            .getListDataContacts(dbConnection, table)
                            .then((value) {
                          print(value.toString());
                          dataProvider.setData(value);

                          setState(() {
                            nextId = nextId + 1;
                            Navigator.of(context).pop();
                          });
                        });
                      });
                    }
                  }
                } catch (err) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(err.toString())));
                  throw new ErrorHint(err.toString());
                }
              },
            ),
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF3EB16F)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            deleteButtonWidget(context, isEditMode, table, id, true, false)
          ],
        );
      },
    );
  }

  Future<void> _showPlacesDialog(
      BuildContext context, String title, bool isEditMode, int id, String table,
      [PlacesModel data]) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _statergyTextCtrl = TextEditingController();
    TextEditingController _landmarkTextCtrl = TextEditingController();
    //_statergyTextCtrl.text = '';
    String addorEdit = 'Add ';
    if (isEditMode && data != null) {
      addorEdit = 'Edit ';
      _statergyTextCtrl.text = data.statergy;
      _landmarkTextCtrl.text = data.landmark;
    }

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        scrollable: true,
        title: Text(addorEdit + title),
        content: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _statergyTextCtrl,
                decoration: InputDecoration(
                  hintText: 'Enter ' + title,
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _landmarkTextCtrl,
                decoration: InputDecoration(
                  hintText: 'Enter Landmark',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ],
          ),
        )),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            child: Text(addorEdit + title,
                style: TextStyle(color: (Colors.cyan[900]))),
            onPressed: () async {
              try {
                if (_formKey.currentState.validate()) {
                  var finaltext = _statergyTextCtrl.text;
                  var landmarktext = _landmarkTextCtrl.text;
                  final dataProvider = getPerfectProvider(widget.table, false);
                  PlacesModel model = PlacesModel(
                      id: id, statergy: finaltext, landmark: landmarktext);
                  if (isEditMode) {
                    await dbhelper
                        .updatePlaces(dbConnection, table, model)
                        .then((value) async {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(title + " " + addorEdit + "Successfull")));
                      await dbhelper
                          .getListDataPlaces(dbConnection, table)
                          .then((value) {
                        dataProvider.setData(value);
                        Navigator.of(context).pop();
                      });
                    });
                  } else {
                    await dbhelper
                        .insertPlaces(dbConnection, table, model)
                        .then((value) async {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(title + " " + addorEdit + "Successfull")));
                      await dbhelper
                          .getListDataPlaces(dbConnection, table)
                          .then((value) {
                        print(value.toString());
                        print(value.length == 0);
                        dataProvider.setData(value);
                        setState(() {
                          nextId = nextId + 1;
                          Navigator.of(context).pop();
                        });
                      });
                    });
                  }
                }
              } catch (err) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(err.toString())));
                throw new ErrorHint(err.toString());
              }
            },
          ),
          //deleteButtonWidget(context, isEditMode, table, id, false)
        ],
      ),
    );
  }
}
