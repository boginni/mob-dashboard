import 'package:flutter/material.dart';

class InputTextSmall extends StatelessWidget {
  const InputTextSmall({Key? key, required this.controller, this.style})
      : super(key: key);

  final TextEditingController controller;
  final bool editable = true;

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      // style: FlutterFlowTheme.of(context).bodyText1,
      textAlign: TextAlign.center,
      style: style,
      decoration: _decore,
    );
  }
}

const _decore = InputDecoration(
  isDense: true,
  // Added this
  contentPadding: EdgeInsets.all(0),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0x00000000),
      width: 1,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0x00000000),
      width: 1,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
    ),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0x00000000),
      width: 1,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
    ),
  ),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0x00000000),
      width: 1,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
    ),
  ),
);
