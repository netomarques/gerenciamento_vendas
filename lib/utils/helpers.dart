import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  Helpers._();

  static DateTime dbDataToDateTime(dataSqlite) {
    try {
      List<String> parts = dataSqlite.split('-');
      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int day = int.parse(parts[2]);
      return DateTime(year, month, day);
    } catch (e) {
      debugPrint(e.toString());
      return DateTime.now();
    }
  }

  static String formatarDateTimeToDateDB(DateTime date) {
    try {
      String formatoDbDate = DateFormat('yyyy-MM-dd').format(date);
      return formatoDbDate;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(
          'Erro ao converter DateTime para String no formato do banco');
    }
  }

  static String formatarDateTimeToString(DateTime date,
      {String format = 'dd/MM/yy'}) {
    try {
      return DateFormat(format).format(date);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao formatar Data');
    }
  }

  static DateTime stringFormatadaToDateTime(stringFormatada) {
    try {
      List<String> parts = stringFormatada.split('/');
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);
      return DateTime(year, month, day);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao converter String para DataTime');
    }
  }

  static Future<DateTime?> showCustomDatePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
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
  }
}
