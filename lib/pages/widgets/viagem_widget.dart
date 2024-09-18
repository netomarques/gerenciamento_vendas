import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class ViagemWidget extends ConsumerWidget {
  final Viagem viagem;
  final NumberFormat _formatterMoeda =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  final NumberFormat _formatterQuantidade = NumberFormat('#,##0.00', 'pt_BR');

  ViagemWidget({
    super.key,
    required this.viagem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viagemRelatorioState = ref.watch(viagemProvider(viagem));
    Size deviceSize = context.devicesize;
    Color cor = viagemRelatorioState.viagem!.dateFechada != null
        ? const Color(0xFF006940)
        : Color.fromARGB(255, 248, 195, 6);

    return Container(
      margin: const EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
      width: deviceSize.width,
      height: deviceSize.height * 0.155,
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(30),
      ),
      // color: cor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textValor('DATA DE CHEGADA', deviceSize),
                  Container(
                    width: deviceSize.width * 0.26,
                    height: deviceSize.height * 0.03,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDFFFF),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        Helpers.formatarDateTimeToString(
                            viagemRelatorioState.viagem!.dateChegada),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF969CAF),
                        ),
                      ),
                    ),
                  ),
                  _textValor('DATA DE FECHAMENTO', deviceSize),
                  Container(
                    width: deviceSize.width * 0.26,
                    height: deviceSize.height * 0.03,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDFFFF),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        viagemRelatorioState.viagem!.dateFechada == null
                            ? ''
                            : Helpers.formatarDateTimeToString(
                                viagemRelatorioState.viagem!.dateFechada!),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF969CAF),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 6, top: 8),
              alignment: Alignment.topRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _textCampo('Peso Total'),
                      Text(
                        _formatterMoeda.format(
                            viagemRelatorioState.viagem!.peso.toDouble()),
                        style: TextStyle(
                          color: const Color(0xFFFDFFFF),
                          fontSize: (deviceSize.width *
                                  0.5 *
                                  deviceSize.height *
                                  0.078 *
                                  0.15) /
                              100,
                        ),
                      ),
                    ],
                  ),
                  _textCampo(viagemRelatorioState.viagem!.barco.nome),
                ],
              ),
            ),
          ),
        ],
      ),
      // child: Row(
      //   children: <Widget>[
      //     Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Container(
      //             width: deviceSize.width * 0.26,
      //             height: deviceSize.height * 0.03,
      //             margin: const EdgeInsets.only(left: 8, top: 8),
      //             decoration: BoxDecoration(
      //               color: const Color(0xFFFDFFFF),
      //               borderRadius: BorderRadius.circular(5),
      //             ),
      //             child: Center(
      //               child: Text(
      //                 Helpers.formatarDateTimeToString(vendaState.venda!.date),
      //                 style: const TextStyle(
      //                   fontSize: 16,
      //                   color: Color(0xFF969CAF),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Container(
      //             width: deviceSize.width * 0.5,
      //             height: deviceSize.height * 0.09,
      //             margin: const EdgeInsets.only(left: 8, top: 8),
      //             child: Row(
      //               children: <Widget>[
      //                 SizedBox(
      //                   width: deviceSize.width * 0.5 * 0.3,
      //                   child: Image.asset(
      //                     "assets/images/checkout_price_icon.png",
      //                   ),
      //                 ),
      //                 Container(
      //                   width: deviceSize.width * 0.5 * 0.3,
      //                   padding: const EdgeInsets.only(top: 8, bottom: 8),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: <Widget>[
      //                       _textCampo('Peso: '),
      //                       _textCampo('Preço/kg: '),
      //                       _textCampo('Desconto: '),
      //                     ],
      //                   ),
      //                 ),
      //                 Container(
      //                   width: deviceSize.width * 0.5 * 0.4,
      //                   padding: const EdgeInsets.only(top: 8, bottom: 8),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: <Widget>[
      //                       _textValor(
      //                           '${_formatterQuantidade.format(vendaState.venda!.quantidade.toDouble())} kg',
      //                           deviceSize),
      //                       _textValor(
      //                           _formatterMoeda
      //                               .format(vendaState.venda!.preco.toDouble()),
      //                           deviceSize),
      //                       _textValor(
      //                           _formatterMoeda.format(
      //                               vendaState.venda!.desconto.toDouble()),
      //                           deviceSize),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ]),
      //     Expanded(
      //       child: Container(
      //         padding: const EdgeInsets.only(right: 6, top: 8),
      //         alignment: Alignment.topRight,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           crossAxisAlignment: CrossAxisAlignment.end,
      //           children: [
      //             Column(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               crossAxisAlignment: CrossAxisAlignment.end,
      //               children: [
      //                 const Text(
      //                   "Total",
      //                   style:
      //                       TextStyle(color: Color(0xFFFDFFFF), fontSize: 12),
      //                 ),
      //                 Text(
      //                   _formatterMoeda
      //                       .format(vendaState.venda!.total!.toDouble()),
      //                   style: TextStyle(
      //                     color: const Color(0xFFFDFFFF),
      //                     fontSize: (deviceSize.width *
      //                             0.5 *
      //                             deviceSize.height *
      //                             0.078 *
      //                             0.15) /
      //                         100,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Text(
      //               vendaState.venda!.cliente.nome,
      //               style:
      //                   const TextStyle(color: Color(0xFFFDFFFF), fontSize: 12),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  _textCampo(text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xFFFDFFFF),
      ),
    );
  }

  _textValor(text, deviceSize) {
    return Text(
      text,
      style: TextStyle(
        fontSize:
            (deviceSize.width * 0.5 * deviceSize.height * 0.078 * 0.095) / 100,
        color: const Color(0xFFFDFFFF),
      ),
    );
  }
}
