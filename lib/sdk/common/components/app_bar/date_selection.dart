import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/configuracao/app_theme.dart';

class AppBarMonthSelection extends StatefulWidget {
  const AppBarMonthSelection({
    Key? key,
    this.initialDate,
    required this.onChange,
  }) : super(key: key);

  final DateTime? initialDate;

  final void Function(DateTime date) onChange;

  @override
  State<AppBarMonthSelection> createState() => _AppBarMonthSelectionState();
}

class _AppBarMonthSelectionState extends State<AppBarMonthSelection> {
  late DateTime curDate;

  late DateTime selectedDate;

  @override
  void initState() {
    curDate = DateTime.now();
    selectedDate = widget.initialDate ?? curDate;
  }

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Row(
        children: [
          Text(
            'Ano',
            style: theme.textTheme.subTitle2(),
          ),
          const SizedBox(
            width: 20,
          ),
          DropdownButton<int?>(
            value: selectedDate.year,
            items: [
              for (int i = -1; i < 4; i++)
                DropdownMenuItem(
                  child: Text(
                    DateFormat('yyyy').format(DateTime(curDate.year - i)),
                    style: theme.textTheme.subTitle(),
                  ),
                  value: curDate.year - i,
                ),
            ],
            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(() {
                selectedDate = DateTime(value, selectedDate.month);
              });

              widget.onChange(selectedDate);
            },
          ),
          SizedBox(
            width: 40,
          ),
          Text(
            'Mes',
            style: theme.textTheme.subTitle2(),
          ),
          SizedBox(
            width: 20,
          ),
          DropdownButton<int?>(
            value: selectedDate.month,
            items: [
              for (int i = 1; i < 13; i++)
                DropdownMenuItem(
                  child: Text(
                    DateFormat('MMMM').format(DateTime(0, i)),
                    style: theme.textTheme.subTitle(),
                  ),
                  value: i,
                ),
            ],
            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(() {
                selectedDate = DateTime(selectedDate.year, value);
              });

              widget.onChange(selectedDate);
            },
          ),
        ],
      ),
    );
  }
}
