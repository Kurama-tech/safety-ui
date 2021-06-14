import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safety/NotificationPlugin.dart';
import 'package:safety/databaseHandler.dart';
import 'package:safety/models/Models.dart';
import 'package:safety/new_entry/new_entry.dart';
import 'package:safety/provider/Universal.dart';
import 'package:safety/success_screen/success_screen.dart';
import 'package:sqflite/sqflite.dart';

class ApponintmentsEntry extends StatefulWidget {
  ApponintmentsEntry({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _AppointmentsEntry createState() => _AppointmentsEntry();
}

class _AppointmentsEntry extends State<ApponintmentsEntry>
    with SingleTickerProviderStateMixin {
  String _setTime, _setDate;

  DatabaseHandler dbhelper = DatabaseHandler();
  Database dbConnection;
  int nextId = 0;
  bool pick = false;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey;

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
        pick = true;
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
    _scaffoldKey = GlobalKey<ScaffoldState>();
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

  @override
  Widget build(BuildContext context) {
    TextEditingController _statergyTextCtrl = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final provider = Provider.of<AppointmentsP>(context, listen: false);
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF3EB16F),
        ),
        centerTitle: true,
        title: Text(
          "Add New Appointment",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PanelTitle(
                    title: "Doctor Name",
                    isRequired: true,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    controller: _statergyTextCtrl,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 60,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 4),
                      child: FlatButton(
                        color: Color(0xFF3EB16F),
                        shape: StadiumBorder(),
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Center(
                          child: Text(
                            pick == false
                                ? " Pick Date"
                                : "${DateFormat.yMd().format(selectedDate)}",
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
                  Container(
                    height: 60,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 4),
                      child: FlatButton(
                        color: Color(0xFF3EB16F),
                        shape: StadiumBorder(),
                        onPressed: () {
                          _selectTime(context);
                        },
                        child: Center(
                          child: Text(
                            pick == false
                                ? " Pick Time"
                                : "${_timeController.text}",
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
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.08,
                right: MediaQuery.of(context).size.height * 0.08,
              ),
              child: Container(
                width: 220,
                height: 70,
                child: FlatButton(
                  color: Color(0xFF3EB16F),
                  shape: StadiumBorder(),
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
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
                            id: nextId,
                            docName: finaltext,
                            dateTime: finalSelected);

                        await dbhelper
                            .insertAppointment(dbConnection, model)
                            .then((value) async {
                          await notificationPlugin
                              .scheduleNotificationAppotintment(
                                  nextId, dt, finaltext);
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return SuccessScreen();
                                  },
                                ),
                              );
                            });
                          });
                        });
                      }
                    } catch (err) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(err.toString())));
                      throw new ErrorHint(err.toString());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
