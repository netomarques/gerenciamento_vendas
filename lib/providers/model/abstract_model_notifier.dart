import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/repository/repository.dart';

abstract class AbstractModelNotifier extends StateNotifier<ModelState> {
  abstract final DataRepository _repository;

  AbstractModelNotifier(ModelState state) : super(state);

  Future<void> insertRecord(Map<String, dynamic> values) async {
    try {
      await _repository.insertRecord(values);
      getAllRecords();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getAllRecords() async {
    try {
      final list = await _repository.getAllRecords();
      state = state.copyWith(list: list);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateRecord(Map<String, dynamic> values, int id) async {
    try {
      await _repository.updateRecord(values, id);
      getAllRecords();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteRecord(int id) async {
    try {
      await _repository.deleteRecord(id);
      getAllRecords();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
