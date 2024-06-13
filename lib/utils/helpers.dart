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

  static String dateTimeToDbDate(String date) {
    try {
      final DateFormat inputDateFormat = DateFormat('dd/MM/yy');
      final DateFormat dbDateFormat = DateFormat('yyyy-MM-dd');
      String formatoBdDate = dbDateFormat.format(
          dbDateFormat.parse(dbDateFormat.format(inputDateFormat.parse(date))));
      return formatoBdDate;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(
          'Erro ao converter DateTime para String no formato do banco');
    }
  }
}
