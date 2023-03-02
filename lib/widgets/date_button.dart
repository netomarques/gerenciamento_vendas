import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateButton extends StatelessWidget {
  late String _dateStart;
  late String _dateEnd;
  final Function carregarVendas;

  late final ValueNotifier<String> _dateStartNotifier;
  late final ValueNotifier<String> _dateEndNotifier;

  final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  final _now = DateTime.now();
  bool _isVisible = false;

  DateButton(this._dateStart, this._dateEnd, this.carregarVendas, {super.key});

  @override
  Widget build(BuildContext context) {
    _dateStartNotifier = ValueNotifier<String>(_dateStart);
    _dateEndNotifier = ValueNotifier<String>(_dateEnd);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ValueListenableBuilder<String>(
          valueListenable: _dateEndNotifier,
          builder: (context, value, child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xff486153),
              ),
              onPressed: () => _showDateRangePicker(context),
              child: Text(
                value,
                style: const TextStyle(fontSize: 20, color: Color(0xFFFDFFFF)),
              ),
            );
          },
        ),
        ValueListenableBuilder<String>(
          valueListenable: _dateStartNotifier,
          builder: (context, value, child) {
            return Visibility(
              visible: _isVisible,
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
                  value,
                  style:
                      const TextStyle(fontSize: 20, color: Color(0xFFFDFFFF)),
                ),
              ),
            );
          },
        ),
      ],
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

      _dateStartNotifier.value = _dateStart;
      _dateEndNotifier.value = _dateEnd;

      _isVisible = picked.start != picked.end ? true : false;

      carregarVendas(_dateStart, _dateEnd);
    }
  }

  void dispose() {
    _dateStartNotifier.dispose();
    _dateEndNotifier.dispose();
  }
}
