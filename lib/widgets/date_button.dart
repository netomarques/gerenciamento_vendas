import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class DateButton extends StatefulWidget {
  final DateTime dateStart;
  final DateTime dateEnd;
  final Function carregarVendas;

  const DateButton(this.dateStart, this.dateEnd, this.carregarVendas,
      {super.key});

  @override
  State<DateButton> createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  late final StreamController<Map<String, dynamic>> _streamController;
  late DateTime _dateStart;
  late DateTime _dateEnd;

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
                Helpers.formatarDateTimeToString(datas["dateEnd"]),
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
                  Helpers.formatarDateTimeToString(datas["dateStart"]),
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
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        end: _dateEnd,
        start: _dateStart,
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
        (picked.start != _dateStart || picked.end != _dateEnd)) {
      _dateStart = picked.start;
      _dateEnd = picked.end;

      Map<String, dynamic> datas = {};
      datas["dateStart"] = picked.start;
      datas["dateEnd"] = picked.end;
      datas["isVisible"] = picked.start != picked.end ? true : false;

      _streamController.add(datas);

      widget.carregarVendas(picked.start, picked.end);
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
