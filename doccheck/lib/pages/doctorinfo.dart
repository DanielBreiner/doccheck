import 'package:flutter/material.dart';
import '../data.dart';

class DoctorInfo extends StatefulWidget {
  DoctorInfo(this.doctor, this.userData, {Key key}) : super(key: key);
  final Doctor doctor;
  final UserData userData;

  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  TextEditingController _textEditingController = TextEditingController();
  DateTime _tempDate = null;

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tempDate = picked;
        _textEditingController
          ..text =
              "${_tempDate.day.toString()}.${_tempDate.month.toString()}.${_tempDate.year.toString()}"
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: _textEditingController.text.length,
              affinity: TextAffinity.upstream));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _tempDate ??= widget.userData.nextAppointments[widget.doctor]
        .subtract(widget.doctor.betweenAppointments(widget.userData));
    _textEditingController.text =
        "${_tempDate.day.toString()}.${_tempDate.month.toString()}.${_tempDate.year.toString()}";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctor.name),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                  "Days till next appointment: " +
                      widget.userData
                          .toNextAppointment(widget.doctor)
                          .toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                widget.doctor.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              )),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _lastAppointmentWidget(),
                Builder(
                  builder: (context) => RaisedButton(
                    onPressed: () {
                      setState(() {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Your last appointment was saved'),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.red,
                        ));
                        widget.userData.nextAppointments[widget.doctor] =
                            _tempDate.add(widget.doctor
                                .betweenAppointments(widget.userData));
                      });
                    },
                    textColor: Colors.white,
                    color: Colors.red,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('Save', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget _lastAppointmentWidget() => Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Date of last appointment",
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              focusNode: AlwaysDisabledFocusNode(),
              controller: _textEditingController,
              onTap: () {
                _showDatePicker();
              },
            ),
          ],
        ),
      );
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
