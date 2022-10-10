import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../sdk/common/formatter/date_time_formatter.dart';

class FormDatePicker extends StatefulWidget {
  final Function(DateTime? date) then;

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  DateFormat? formatter;

  String hint;
  final DateTime? startingDate;

  final InputDecoration? decoration;

  FormDatePicker(
      {Key? key,
      required this.then,
      required this.initialDate,
      required this.firstDate,
      required this.lastDate,
      this.formatter,
      this.hint = '',
      this.startingDate,
      this.decoration})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker> {
  static DateFormat defaultFormatter = DateFormatter.normalData;

  DateTime? time;
  final controller = TextEditingController();

  bool outRebuild = false;

  late final DateFormat formatter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    formatter = widget.formatter ?? defaultFormatter;

    time = widget.initialDate;

    controller.text = time != null ? formatter.format(time!) : '';

    // print(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (outRebuild) {
      time = widget.initialDate;
      controller.text = time != null ? formatter.format(time!) : '';
    }

    outRebuild = true;

    // print(controller.text);

    return TextFormField(
      controller: controller,
      focusNode: AlwaysDisabledFocusNode(),
      textAlign: TextAlign.center,
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: widget.initialDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          // currentDate: widget.initialDate,
        ).then((value) {
          if (value != null) {
            setState(() {
              time = value;
              controller.text = time != null ? formatter.format(time!) : '';
              outRebuild = false;
            });
            widget.then(value);
          }
        });
      },
      decoration: widget.decoration == null
          ? InputDecoration(hintText: widget.hint)
          : widget.decoration!,
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
