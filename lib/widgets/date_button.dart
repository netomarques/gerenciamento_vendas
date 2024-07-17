import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateButton extends StatefulWidget {
  final String dateStart;
  final String dateEnd;
  final Function carregarVendas;

  const DateButton(this.dateStart, this.dateEnd, this.carregarVendas,
      {super.key});

  @override
  State<DateButton> createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  final _now = DateTime.now();
  late final StreamController<Map<String, dynamic>> _streamController;
  late String _dateStart;
  late String _dateEnd;

  @override
  void initState() {
    super.initState();
    _dateStart = widget.dateStart;
    _dateEnd = widget.dateEnd;
    _streamController = StreamController();
    _streamController.add(
        {"dateStart": _dateStart, "dateEnd": _dateEnd, "isVisible": false});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        Map<String, dynamic> datas = snapshot.data!;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xff486153),
              ),
              onPressed: () => _showDateRangePicker(context),
              child: Text(
                datas["dateEnd"],
                style: const TextStyle(fontSize: 18, color: Color(0xFFFDFFFF)),
              ),
            ),
            Visibility(
              visible: datas["isVisible"],
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xff486153),
                ),
                onPressed: () => _showDateRangePicker(context),
                child: Text(
                  datas["dateStart"],
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFFFDFFFF)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDateRangePicker(context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: _now,
      initialDateRange: DateTimeRange(
        end: _dateFormat.parse(_dateEnd),
        start: _dateFormat.parse(_dateStart),
      ),
      builder: (context, child) {
        return Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400.0,
              ),
              child: child,
            )
          ],
        );
      },
    );

    if (picked != null &&
        (_dateFormat.format(picked.start) != _dateStart ||
            _dateFormat.format(picked.end) != _dateEnd)) {
      _dateStart = _dateFormat.format(picked.start);
      _dateEnd = _dateFormat.format(picked.end);

      Map<String, dynamic> datas = {};
      datas["dateStart"] = _dateStart;
      datas["dateEnd"] = _dateEnd;
      datas["isVisible"] = picked.start != picked.end ? true : false;

      _streamController.add(datas);

      widget.carregarVendas(_dateStart, _dateEnd);
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
