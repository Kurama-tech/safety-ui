import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safety/databaseHandler.dart';
import 'package:safety/models/Models.dart';
import 'package:safety/provider/Universal.dart';
import 'package:sqflite/sqflite.dart';

class Medication extends StatefulWidget {
  Medication({Key key, this.title}) : super(key: key);

  final String title;

  _MedicationState createState() => _MedicationState();
}

class _MedicationState extends State<Medication>
    with SingleTickerProviderStateMixin {
      String _setTime, _setDate;

  DatabaseHandler dbhelper = DatabaseHandler();
  Database dbConnection;
  int nextId = 0;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    final provider2 = Provider.of<MedicationsP>(context, listen: false);
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
            DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    dbhelper.onDbInit().then((database) {
      dbConnection = database;
      dbhelper.getListMedications(database).then((value) {
        provider2.setData(value);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MedicationsP>(context, listen: true);
    print(provider.data.toString());
    // TODO: implement build
    return Center(
        child: provider.flag || provider.noData
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Wrap(children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.data.length,
                      itemBuilder: (context, i) {
                        final datalist = provider.data[i];
                        return Container(
                          height: 100,
                          child: InkWell(
                            child: Card(
                              elevation: 5,
                              child: Center(
                                child: ListTile(
                                  leading: Text(datalist.id.toString()),
                                  title: Text(datalist.tabName),
                                  subtitle: Text(datalist.dateTime),
                                  trailing: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {},
                          ),
                        );
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _showStepper(context);
                      },
                      child: Text('Add Appointments'),
                    ),
                  )
                ]),
              ));
  }

  Future<void> _showStepper(BuildContext context) async {
    final provider = Provider.of<MedicationsP>(context, listen: false);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _statergyTextCtrl = TextEditingController();
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add an Medications'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _statergyTextCtrl,
                          decoration: InputDecoration(
                            hintText: 'Enter Medication Name',
                          ),
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Choose Date',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5),
                            ),
                            InkWell(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                width: _width / 1.7,
                                height: _height / 9,
                                margin: EdgeInsets.only(top: 30),
                                alignment: Alignment.center,
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 40),
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  validator: (String value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Choose a Date';
                                    }
                                    return null;
                                  },
                                  controller: _dateController,
                                  onSaved: (String val) {
                                    _setDate = val;
                                  },
                                  decoration: InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      // labelText: 'Time',
                                      contentPadding:
                                          EdgeInsets.only(top: 0.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Choose Time',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5),
                            ),
                            InkWell(
                              onTap: () {
                                _selectTime(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                width: _width / 1.7,
                                height: _height / 9,
                                alignment: Alignment.center,
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 40),
                                  textAlign: TextAlign.center,
                                  onSaved: (String val) {
                                    _setTime = val;
                                  },
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  controller: _timeController,
                                  decoration: InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      // labelText: 'Time',
                                      contentPadding: EdgeInsets.all(5)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Add'),
                onPressed: () async {
                  try {
                    if (_formKey.currentState.validate()) {
                      var finaltext = _statergyTextCtrl.text;
                      DateTime dt = new DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute);
                      String finalSelected = dt.toString();
                      MedicationsModel model = MedicationsModel(
                          id: 1, tabName: finaltext, dateTime: finalSelected);
                      await dbhelper
                          .insertMedication(dbConnection, model)
                          .then((value) {
                        dbhelper
                            .getListAppointments(dbConnection)
                            .then((value) {
                          provider.setData(value);
                        });
                      });
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
            ],
          );
        });
  }
}

