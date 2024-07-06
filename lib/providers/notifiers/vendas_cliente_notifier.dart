// import 'package:flutter/material.dart';
// import 'package:vendas_gerenciamento/model/model.dart';
// import 'package:vendas_gerenciamento/providers/providers.dart';
// import 'package:vendas_gerenciamento/services/service.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class VendasClienteNotifier extends StateNotifier<VendaState> {
//   // final DataRepository _repository;
//   final VendaService service;

//   VendasClienteNotifier(this.service) : super(const VendaState.initial());

//   // void salvarVenda(Venda venda) async {
//   //   try {
//   //     await service.salvarVenda(venda);
//   //     getVendasPorCliente();
//   //   } catch (e) {
//   //     debugPrint(e.toString());
//   //   }
//   // }

//   void getVendasPorCliente(idCliente) async {
//     try {
//       final List<Venda> vendasDoCliente =
//           await service.getVendasPorCliente(idCliente);
//       state = state.copyWith(list: vendasDoCliente);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   void getVendasPorData(String startDate, String endDate) async {
//     try {
//       final List<Venda> vendas =
//           await service.getVendasPorData(startDate, endDate);
//       state = state.copyWith(list: vendas);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   // Future<void> updateRecord(Map<String, dynamic> values, int id) async {
//   //   try {
//   //     // await _repository.updateRecord(values, id);
//   //     getVendasPorCliente();
//   //   } catch (e) {
//   //     debugPrint(e.toString());
//   //   }
//   // }

//   // Future<void> deleteRecord(int id) async {
//   //   try {
//   //     // await _repository.deleteRecord(id);
//   //     getVendas();
//   //   } catch (e) {
//   //     debugPrint(e.toString());
//   //   }
//   // }
// }
