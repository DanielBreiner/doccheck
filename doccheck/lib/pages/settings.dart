import 'package:flutter/material.dart';
import '../data.dart';

class Settings extends StatefulWidget {
  Settings(this.userData, {Key key, this.title}) : super(key: key);

  UserData userData;
  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _genderPicker(),
            _dateOfBirthWidget(),
            RaisedButton(
              onPressed: () {},
              textColor: Colors.white,
              color: Colors.blue,
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
              groupValue: widget.userData.gender,
              onChanged: (Gender value) {
                setState(() {
                  widget.userData.gender = value;
                });
              },
            ),
            RadioListTile<Gender>(
              title: const Text('Male'),
              value: Gender.male,
              groupValue: widget.userData.gender,
              onChanged: (Gender value) {
                setState(() {
                  widget.userData.gender = value;
                });
              },
            ),
            RadioListTile<Gender>(
              title: const Text('Other'),
              value: Gender.other,
              groupValue: widget.userData.gender,
              onChanged: (Gender value) {
                setState(() {
                  widget.userData.gender = value;
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
