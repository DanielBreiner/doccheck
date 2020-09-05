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
      initialEntryMode: DatePickerEntryMode.input,
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.doctor.name),
        ),
        body: Column(children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: Text(
                  widget.userData.toNextAppointment(widget.doctor).toString() +
                      " Days to next appointment")),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(widget.doctor.description)),
          Container(child: _lastAppointmentWidget())
        ]));
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

// class DoctorInfo extends StatelessWidget {
//   final Doctor doctor;
//   DoctorInfo(this.doctor);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(doctor.name),
//         ),
//         body: Column(children: [
//           Container(
//               margin: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
//               child: Text(doctor.toNextAppointment(UserData()).toString() +
//                   " Days to next appointment")),
//           Container(
//               margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//               child: Text(doctor.description)),
//           Container()
//         ]));
//   }
// }
