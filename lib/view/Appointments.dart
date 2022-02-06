import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:my_safety/NotificationPlugin.dart';
import 'package:my_safety/databaseHandler.dart';
import 'package:my_safety/models/Models.dart';
import 'package:my_safety/provider/Universal.dart';
import 'package:my_safety/view/Appointments_entry.dart';
import 'package:sqflite/sqflite.dart';

class Appointments extends StatefulWidget {
  Appointments({Key key, this.title}) : super(key: key);

  final String title;

  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments>
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

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {}

  onNotificationClick(String payload) {}

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
    //final provider = Provider.of<AppointmentsP>(context, listen: false);
    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
    final provider = Provider.of<AppointmentsP>(context, listen: false);
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
            DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    dbhelper.onDbInit().then((database) {
      dbConnection = database;
      dbhelper.getLastID(database, 'Appointments').then((value) {
        nextId = value + 1;
      });
      dbhelper.getListAppointments(database).then((value) {
        provider.setData(value);
      });
    });

    super.initState();
  }

  Widget noDataProgress(bool nodata) {
    final provider = Provider.of<AppointmentsP>(context);
    if (provider.noData) {
      return Container(
        color: Color(0xFFF6F8FC),
        child: Column(
          children: [
            Flexible(
              flex: 7,
              child: Container(
                color: Color(0xFFF6F8FC),
                child: Center(
                  child: Text(
                    "Press + to add a Appointment",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFFC9C9C9),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 4),
                  child: FlatButton(
                    color: Color(0xFF3EB16F),
                    shape: StadiumBorder(),
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder<Null>(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return AnimatedBuilder(
                                animation: animation,
                                builder: (BuildContext context, Widget child) {
                                  return Opacity(
                                    opacity: animation.value,
                                    child: ApponintmentsEntry(),
                                  );
                                });
                          },
                          transitionDuration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Add + Appointment",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    return Container(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentsP>(context);
    // TODO: implement build
    return Container(
      child: !provider.flag || provider.noData
          ? noDataProgress(provider.noData)
          : ListView(shrinkWrap: true, children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.data.length,
                  itemBuilder: (context, i) {
                    final datalist = provider.data[i];
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: InkWell(
                        highlightColor: Colors.white,
                        splashColor: Colors.grey,
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Hero(
                                  tag: datalist.docName,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      "Dr " + datalist.docName,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Color(0xFF3EB16F),
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  parsedDatetime(datalist.dateTime),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFC9C9C9),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {
                          await _showStepper(
                              context, datalist.id, true, datalist);
                        },
                      ),
                    );
                  }),
              Container(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 4),
                  child: FlatButton(
                    color: Color(0xFF3EB16F),
                    shape: StadiumBorder(),
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder<Null>(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return AnimatedBuilder(
                                animation: animation,
                                builder: (BuildContext context, Widget child) {
                                  return Opacity(
                                    opacity: animation.value,
                                    child: ApponintmentsEntry(),
                                  );
                                });
                          },
                          transitionDuration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Add + Appointment",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
    );
  }

  Widget deleteButtonWidget(
      BuildContext context, bool showDelete, String table, int id) {
    final dataProvider = Provider.of<AppointmentsP>(context, listen: false);
    if (showDelete) {
      return TextButton(
        child: Text('Delete'),
        onPressed: () async {
          await dbhelper
              .deleteUniversal(dbConnection, table, id)
              .then((value) async {
            notificationPlugin.cancelNotification(id);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Delete Successfull")));

            await dbhelper.getListAppointments(dbConnection).then((value) {
              dataProvider.setData(value);
              setState(() {
                nextId = nextId - 1;
                Navigator.of(context).pop();
              });
            });
          });
        },
      );
    }
    return null;
  }

  String parsedDatetime(String date) {
    var parsedDate = DateTime.parse(date);
    var pdate = DateFormat.yMd().format(parsedDate);
    var ptime = formatDate(
        DateTime(2019, 08, 1, parsedDate.hour, parsedDate.minute),
        [hh, ':', nn, " ", am]).toString();
    String finalParsed = "on " + pdate + " at " + ptime;
    return finalParsed;
  }

  Future<void> _showStepper(BuildContext context, int id, bool isEdit,
      [AppointmentsModel data]) async {
    final provider = Provider.of<AppointmentsP>(context, listen: false);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _statergyTextCtrl = TextEditingController();
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    String addOrEdit = 'Add';
    if (isEdit && data != null) {
      addOrEdit = 'Edit';
      _statergyTextCtrl.text = data.docName;
      var parsedDate = DateTime.parse(data.dateTime);
      _timeController.text = formatDate(
          DateTime(2019, 08, 1, parsedDate.hour, parsedDate.minute),
          [hh, ':', nn, " ", am]).toString();
      selectedDate = parsedDate;
      selectedTime =
          TimeOfDay(hour: parsedDate.hour, minute: parsedDate.minute);
      _dateController.text = DateFormat.yMd().format(selectedDate);
    }
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(addOrEdit + ' Appointment'),
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
                            hintText: 'Enter Doctor Name',
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
                            InkWell(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                width: _width / 1.7,
                                height: _height / 9,
                                margin: EdgeInsets.only(top: 30),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xFF3EB16F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.white),
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
                                      contentPadding: EdgeInsets.all(5)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                _selectTime(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                width: _width / 1.7,
                                height: _height / 9,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xFF3EB16F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.white),
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
                child: Text(addOrEdit),
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
                      AppointmentsModel model = AppointmentsModel(
                          id: id, docName: finaltext, dateTime: finalSelected);
                      if (isEdit) {
                        await dbhelper
                            .updateAppointment(dbConnection, model)
                            .then((value) async {
                          await notificationPlugin
                              .scheduleNotificationAppotintment(
                                  id, dt, finaltext);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Appointment Edited Successfully")));
                          dbhelper
                              .getListAppointments(dbConnection)
                              .then((value) {
                            provider.setData(value);
                            Navigator.of(context).pop();
                          });
                        });
                      } else {
                        await dbhelper
                            .insertAppointment(dbConnection, model)
                            .then((value) async {
                          await notificationPlugin
                              .scheduleNotificationAppotintment(
                                  id, dt, finaltext);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Appointment Added Successfully")));
                          dbhelper
                              .getListAppointments(dbConnection)
                              .then((value) {
                            print("value added:" + value.toString());
                            provider.setData(value);
                            print("provider data noData status:" +
                                provider.noData.toString());
                            print("value added:" + provider.flag.toString());
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
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              deleteButtonWidget(context, isEdit, 'Appointments', id)
            ],
          );
        });
  }
}
