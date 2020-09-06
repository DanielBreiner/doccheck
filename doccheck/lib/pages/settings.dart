import 'package:flutter/material.dart';
import '../data.dart';

class Settings extends StatefulWidget {
  Settings(this.userData, {Key key}) : super(key: key);

  final UserData userData;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _textEditingController = TextEditingController();
  DateTime _tempBirth = null;
  Gender _tempGender = null;

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tempBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null) {
      setState(() {
        _tempBirth = picked;
        _textEditingController
          ..text =
              "${_tempBirth.day.toString()}.${_tempBirth.month.toString()}.${_tempBirth.year.toString()}"
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: _textEditingController.text.length,
              affinity: TextAffinity.upstream));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _tempGender ??= widget.userData.gender;
    _tempBirth ??= widget.userData.birthDate;
    _textEditingController.text =
        "${_tempBirth.day.toString()}.${_tempBirth.month.toString()}.${_tempBirth.year.toString()}";
    print(widget.userData.gender);
    print(_tempGender);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _genderPicker(),
            _dateOfBirthWidget(),
            RaisedButton(
              onPressed: () {
                setState(() {
                  widget.userData.setData(_tempBirth, _tempGender);
                });
              },
              textColor: Colors.white,
              color: Colors.red,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: const Text('Save', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderPicker() => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Your gender",
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 20),
            ),
            Container(),
            RadioListTile<Gender>(
              title: const Text('Female'),
              value: Gender.female,
              groupValue: _tempGender,
              onChanged: (Gender value) {
                setState(() {
                  _tempGender = value;
                });
              },
            ),
            RadioListTile<Gender>(
              title: const Text('Male'),
              value: Gender.male,
              groupValue: _tempGender,
              onChanged: (Gender value) {
                setState(() {
                  _tempGender = value;
                });
              },
            ),
            RadioListTile<Gender>(
              title: const Text('Other'),
              value: Gender.other,
              groupValue: _tempGender,
              onChanged: (Gender value) {
                setState(() {
                  _tempGender = value;
                });
              },
            ),
          ],
        ),
      );

  Widget _dateOfBirthWidget() => Container(
        padding: EdgeInsets.only(top: 10, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Your date of birth",
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
