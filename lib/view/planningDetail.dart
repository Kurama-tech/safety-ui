import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety/databaseHandler.dart';
import 'package:safety/models/Models.dart';
import 'package:safety/provider/Universal.dart';
import 'package:sqflite/sqflite.dart';

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
  bool noData = false;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    final dataProvider = getPerfectProvider(widget.table, false);
    bool isContact = widget.table == 'Contacts' ? true : false;
    dbhelper.onDbInit().then((database) {
      //dbhelper.insertUnversal(database, this.widget.table, model);
      //Rdbhelper.insertContact(database, this.widget.table, modelC);
      dbConnection = database;
      dbhelper.getLastID(database, this.widget.table).then((value) {
        print(widget.table);
        print(value);
        print(isContact);
        isContactG = isContact;
        itemCount = value;
        nextId = itemCount + 1;
        if (value > 0) {
          if (isContact) {
            print('helloo ooo');
            dbhelper
                .getListDataContacts(database, this.widget.table)
                .then((value) {
              dataProvider.setData(value);
            });
          } else {
            dbhelper.getListData(database, this.widget.table).then((value) {
              dataProvider.setData(value);
            });
          }
        } else {
          setState(() {
            noData = true;
          });
        }
      });
    });

    super.initState();
  }

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
      default:
        {
          throw Error();
        }
        break;
    }
  }

  Widget noDataProgress(bool nodata) {
    if (noData) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset("assets/images/3009286-ai.png")),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.cyan[900])),
              
              onPressed: () {
                if(isContactG){
                   _showMyDialogContacts(context, this.widget.title,
                              false, nextId, this.widget.table);
                }
                else{
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
    return Center(
        child: !dataProvider.flag || dataProvider.noData
            ? noDataProgress(dataProvider.noData)
            : ListView(
                children: <Widget>[
                  universalBuild(dataProvider, isContact),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.cyan[900])),
                      onPressed: () {
                        print(isContact);
                        if (isContact) {
                          _showMyDialogContacts(context, this.widget.title,
                              false, nextId, this.widget.table);
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

  Widget universalBuild(universalData, bool isContacts) {
    if (isContacts) {
      print("return Contacts");
      return contactsBuild(universalData);
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: universalData.data.length,
        itemBuilder: (context, i) {
          final datalist = universalData.data[i];
          return Container(
            height: 100,
            child: InkWell(
              child: Card(
                elevation: 5,
                child: Center(
                  child: ListTile(
                    leading: Text(datalist.id.toString()),
                    title: Text(datalist.statergy),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showMyDialog(context, this.widget.title, true,
                            datalist.id, this.widget.table, datalist);
                      },
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
            height: 100,
            child: InkWell(
              child: Card(
                elevation: 5,
                child: Center(
                  child: ListTile(
                    leading: Text(datalist.id.toString()),
                    title: Text(datalist.name),
                    subtitle: Text(datalist.number.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showMyDialogContacts(context, this.widget.title, true,
                            datalist.id, this.widget.table, datalist);
                      },
                    ),
                  ),
                ),
              ),
              onTap: () {},
            ),
          );
        });
  }

  Future<void> _showMyDialog(
      BuildContext context, String title, bool isEditMode, int id, String table,
      [UnversalModel data]) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _statergyTextCtrl = TextEditingController();
    String addorEdit = 'Add';
    if (isEditMode && data != null) {
      addorEdit = 'Edit ';
      _statergyTextCtrl.text = data.statergy;
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
                        controller: _statergyTextCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter ' + title,
                        ),
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
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
              child: Text(addorEdit + title),
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
                          dataProvider.setData(value);
                          Navigator.of(context).pop();
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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            deleteButtonWidget(context, isEditMode, table, id, false)
          ],
        );
      },
    );
  }

  Widget deleteButtonWidget(BuildContext context, bool showDelete, String table,
      int id, bool isContacts) {
    final dataProvider = getPerfectProvider(table, false);
    if (showDelete) {
      return TextButton(
        child: Text('Delete'),
        onPressed: () async {
          await dbhelper
              .deleteUniversal(dbConnection, table, id)
              .then((value) async {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Delete Successfull")));
            if (isContacts) {
              await dbhelper
                  .getListDataContacts(dbConnection, table)
                  .then((value) {
                dataProvider.setData(value);
                Navigator.of(context).pop();
              });
            } else {
              await dbhelper.getListData(dbConnection, table).then((value) {
                dataProvider.setData(value);
                Navigator.of(context).pop();
              });
            }
          });
        },
      );
    }
    return null;
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
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Number With Country Code',
                        ),
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length > 12 || value.length < 12) {
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
              child: Text(addorEdit + title),
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
                          Navigator.of(context).pop();
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
                          dataProvider.setData(value);
                          Navigator.of(context).pop();
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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            deleteButtonWidget(context, isEditMode, table, id, true)
          ],
        );
      },
    );
  }
}
