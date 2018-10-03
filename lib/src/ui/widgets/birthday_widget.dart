import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/src/ui/widgets/base_widget.dart';
import 'package:flutter_paystack/src/ui/widgets/buttons.dart';
import 'package:flutter_paystack/src/ui/widgets/custom_dialog.dart';
import 'package:intl/intl.dart';

class BirthdayWidget extends StatefulWidget {
  final String message;

  BirthdayWidget({@required this.message});

  @override
  _BirthdayWidgetState createState() => _BirthdayWidgetState();
}

class _BirthdayWidgetState extends BaseState<BirthdayWidget> {
  var _heightBox = const SizedBox(height: 20.0);
  DateTime _pickedDate;

  @override
  void initState() {
    super.initState();
    confirmationMessage = 'Do you want to cancel birthday input?';
  }

  @override
  Widget buildChild(BuildContext context) {
    return new CustomAlertDialog(
        content: new SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: new Column(
          children: <Widget>[
            new Image.asset('assets/images/dob.png',
                width: 30.0, package: 'flutter_paystack'),
            _heightBox,
            new Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 15.0,
              ),
            ),
            _heightBox,
            _pickedDate == null
                ? new WhiteButton(
                    onPressed: _selectBirthday, text: 'Pick birthday')
                : new WhiteButton(
                    onPressed: _selectBirthday,
                    flat: true,
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Flexible(flex: 4, child: dateItem(_getMonth())),
                        new Flexible(flex: 2, child: dateItem(_getDay())),
                        new Flexible(flex: 3, child: dateItem(_getYear()))
                      ],
                    ),
                  ),
            new SizedBox(
              height: _pickedDate == null ? 5.0 : 20.0,
            ),
            _pickedDate == null
                ? new Container()
                : new GreenButton(onPressed: _onAuthorize, text: 'Authorize'),
            new Container(
              padding:
                  new EdgeInsets.only(top: _pickedDate == null ? 15.0 : 20.0),
              child: new WhiteButton(
                onPressed: onCancelPress,
                text: 'Cancel',
                flat: true,
                bold: true,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<DateTime> _showDatePicker() {
    var now = new DateTime.now();
    return showDatePicker(
        context: context,
        selectableDayPredicate: (DateTime val) =>
            val.year > now.year && val.month > now.month && val.day > now.day
                ? false
                : true,
        initialDate: now,
        firstDate: new DateTime(1900),
        lastDate: now);
  }

  void _selectBirthday() async {
    DateTime result = await _showDatePicker();
    setState(() => _pickedDate = result);
  }

  Widget dateItem(String text) {
    const side = const BorderSide(color: Colors.grey, width: 0.5);
    return new Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(const Radius.circular(3.0)),
          border:
              const Border(top: side, right: side, bottom: side, left: side)),
      child: new Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _getMonth() {
    return new DateFormat('MMMM').format(_pickedDate);
  }

  String _getDay() {
    return new DateFormat('dd').format(_pickedDate);
  }

  String _getYear() {
    return new DateFormat('yyyy').format(_pickedDate);
  }

  void _onAuthorize() {
    String date = new DateFormat('yyyy-MM-dd').format(_pickedDate);
    Navigator.of(context).pop(date);
  }
}
