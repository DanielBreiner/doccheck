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

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.userData.birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        widget.userData.birthDate = picked;
        _textEditingController
          ..text =
              "${widget.userData.birthDate.day.toString()}.${widget.userData.birthDate.month.toString()}.${widget.userData.birthDate.year.toString()}"
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: _textEditingController.text.length,
              affinity: TextAffinity.upstream));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.text =
        "${widget.userData.birthDate.day.toString()}.${widget.userData.birthDate.month.toString()}.${widget.userData.birthDate.year.toString()}";
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
                  widget.userData.toNextAppointment(widget.doctor).toString() +
                      " Days to next appointment")),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(widget.doctor.description)),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _lastAppointmentWidget(),
                RaisedButton(
                  onPressed: () {},
                  textColor: Colors.white,
                  color: Colors.red,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text('Save', style: TextStyle(fontSize: 16)),
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
        padding: EdgeInsets.only(top: 20, bottom: 10),
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
