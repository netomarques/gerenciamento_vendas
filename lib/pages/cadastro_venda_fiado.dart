import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';
import 'package:vendas_gerenciamento/widgets/acoes_text_button.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field2.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CadastroVendaFiado extends ConsumerStatefulWidget {
  static CadastroVendaFiado builder(
          BuildContext context, GoRouterState state) =>
      const CadastroVendaFiado();

  const CadastroVendaFiado({super.key});

  @override
  ConsumerState<CadastroVendaFiado> createState() => _CadastroVendaFiadoState();
}

class _CadastroVendaFiadoState extends ConsumerState<CadastroVendaFiado> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _valorTotalController;
  late final TextEditingController _dataVendaController;
  late final TextEditingController _descontoController;
  late Venda _venda;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void setCliente(Cliente? selectClienteDropdown) {
    _venda = _venda.copyWith(cliente: selectClienteDropdown);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB710A),
        title: const Text(
          'Venda (Fiado)',
          style: TextStyle(color: Color(0xFFFDFFFF)),
        ),
      ),
      // resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              _containerTextForm(
                  Center(child: DropdownClienteWidget(onChanged: setCliente))),
              // _containerCliente(),
              _containerTextForm(_textValorTotal()),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _containerTextForm(
                      AppTextFormField2(
                        '01/01/01',
                        'Data',
                        TextInputType.datetime,
                        _validatorData,
                        _onSavedData,
                        onTap: _showDatePicker,
                        controller: _dataVendaController,
                        isReadOnly: true,
                      ),
                    ),
                    _containerTextForm(
                      AppTextFormField2(
                        '0.00 kg',
                        'Quantidade(kg)',
                        TextInputType.number,
                        _validatorQuantidade,
                        _onSavedQuantidade,
                        onChanged: _onChangedQuantidade,
                        formato: [
                          FilteringTextInputFormatter.digitsOnly,
                          QuantidadeFormato()
                        ],
                      ),
                    ),
                    _containerTextForm(
                      AppTextFormField2(
                        'R\$ 0.00',
                        'Preço/kg',
                        TextInputType.number,
                        _validatorPreco,
                        _onSavedPreco,
                        onChanged: _onChangedPreco,
                        formato: [
                          FilteringTextInputFormatter.digitsOnly,
                          MoedaFormato()
                        ],
                      ),
                    ),
                    _containerTextForm(
                      AppTextFormField2(
                        'R\$ 0.00',
                        'Desconto',
                        TextInputType.number,
                        _validatorDesconto,
                        _onSavedDesconto,
                        onChanged: _onChangedDesconto,
                        controller: _descontoController,
                        formato: [
                          FilteringTextInputFormatter.digitsOnly,
                          MoedaFormato()
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60, bottom: 8),
                        child: AcoesTextButton(
                          onFunction: _submitForm,
                          text: 'Cadastrar Venda',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _textValorTotal() {
    return TextField(
      controller: _valorTotalController,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFFEB710A),
      ),
      decoration: InputDecoration(
        labelText: 'Total',
        labelStyle: const TextStyle(fontSize: 14, color: Color(0xFF006940)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        filled: true,
        fillColor: const Color(0xFFEB710A).withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: const BorderSide(
            color: Color(0xFF006940),
            width: 1.0,
          ),
        ),
      ),
      enabled: false,
    );
  }

  // _containerCliente() {
  //   return _containerTextForm(
  //     TextField(
  //       // controller: TextEditingController(
  //       //     text: "${widget.cliente.nome} - ${widget.cliente.telefone}"),
  //       controller: TextEditingController(text: "Nome Cliente - 92993049893"),
  //       style: const TextStyle(
  //         fontSize: 14,
  //         color: Color(0xFF006940),
  //       ),
  //       decoration: InputDecoration(
  //         labelText: 'Cliente',
  //         labelStyle: const TextStyle(fontSize: 14, color: Color(0xFF910029)),
  //         contentPadding: const EdgeInsets.symmetric(
  //           horizontal: 16.0,
  //           vertical: 10.0,
  //         ),
  //         filled: true,
  //         fillColor: const Color(0xFFFDFFFF).withOpacity(0.75),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(32.0),
  //           borderSide: BorderSide.none,
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(32.0),
  //           borderSide: const BorderSide(
  //             color: Color(0xFF006940),
  //             width: 1.0,
  //           ),
  //         ),
  //       ),
  //       enabled: false,
  //     ),
  //   );
  // }

  _containerTextForm(widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, right: 32),
      child: widget,
    );
  }

  void _onSavedPreco(String value) {
    // _venda.preco = double.parse(value);
    _venda = _venda.copyWith(
        preco: double.parse(value.substring(3).replaceAll(',', '.')));
  }

  String? _validatorPreco(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o preço do quilo';
      } else {
        double.parse(value.substring(3).replaceAll(',', '.'));
      }
    } on FormatException {
      return 'Por favor, informe um valor numérico válido para o preço';
    } catch (e) {
      return 'Erro ao validar preço';
    }

    return null;
  }

  String? _onChangedPreco(String? value) {
    String? error = _validatorPreco(value);

    try {
      if (error != null) {
        return error;
      } else {
        // _venda.preco = double.parse(value!);
        _venda = _venda.copyWith(
            preco: double.parse(value!.substring(3).replaceAll(',', '.')));
        _atualizaValorTotal();
      }
    } catch (e) {
      return 'Erro não identificado';
    }
    return null;
  }

  void _onSavedQuantidade(String value) {
    // _venda.quantidade = double.parse(value);
    _venda = _venda.copyWith(
        quantidade: double.parse(
            value.replaceAll(RegExp(r' kg'), '').replaceAll(',', '.')));
  }

  String? _validatorQuantidade(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe a quantidade vendida';
      }

      print(value.replaceAll(RegExp(r' kg'), '').replaceAll(',', '.'));
      double.parse(value.replaceAll(RegExp(r' kg'), '').replaceAll(',', '.'));
    } on FormatException {
      return 'Por favor, informe um valor numérico válido \npara a quantidade vendida';
    } catch (e) {
      return 'Erro ao validar Quantidade';
    }

    return null;
  }

  String? _onChangedQuantidade(String? value) {
    String? error = _validatorQuantidade(value);

    try {
      if (error != null) {
        return error;
      } else {
        // _venda.quantidade = double.parse(value!);
        _venda = _venda.copyWith(
            quantidade: double.parse(
                value!.replaceAll(RegExp(r' kg'), '').replaceAll(',', '.')));
        _atualizaValorTotal();
      }
    } catch (e) {
      return 'Erro não identificado';
    }

    return null;
  }

  void _onSavedData(String value) {
    _venda = _venda.copyWith(date: Helpers.stringFormatadaToDateTime(value));

    // _venda.date =
    //     dateFormatBanco.parse(dateFormatBanco.format(_dateFormat.parse(value)));
  }

  String? _validatorData(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe a date da venda';
      } else {
        Helpers.stringFormatadaToDateTime(value);
      }
    } catch (e) {
      return 'Por favor, verifique o formato da data da venda';
    }

    return null;
  }

  void _onSavedDesconto(String value) {
    // _venda.desconto = double.parse(value);
    _venda = _venda.copyWith(
        desconto: double.parse(value.substring(3).replaceAll(',', '.')));
  }

  String? _validatorDesconto(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o desconto';
      }

      double.parse(value.substring(3).replaceAll(',', '.'));
    } on FormatException {
      return 'Por favor, informe um valor numérico válido para o desconto';
    } catch (e) {
      return 'erro não identificado';
    }

    return null;
  }

  String? _onChangedDesconto(String? value) {
    String? error = _validatorDesconto(value);

    try {
      if (error != null) {
        return error;
      }
      // _venda.desconto = double.parse(value!);
      _venda = _venda.copyWith(
          desconto: double.parse(value!.substring(3).replaceAll(',', '.')));
      _atualizaValorTotal();
    } on FormatException {
      return 'Por favor, informe um valor numérico válido para o desconto';
    } catch (e) {
      return 'Erro não identificado';
    }

    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String msg = '';
      try {
        if (_venda.cliente.id == 1) {
          msg = 'Selecione um cliente';
        } else {
          // final abatimento = Abatimento(
          //     idVenda: 0, valor: _venda.total!, dateAbatimento: _venda.date);
          await ref
              .read(listaVendasProvider.notifier)
              .salvarVendaFiado(_venda, null);
          msg = 'Venda cadastrada com sucesso';
          _formKey.currentState!.reset();
          _limparCampos();
        }
      } catch (e) {
        msg = e.toString();
      } finally {
        _exibirDialog(msg);
      }
    }
  }

  void _limparCampos() {
    _venda = Venda.initial(date: DateTime.now(), cliente: Cliente.initial());
    _dataVendaController.text = Helpers.formatarDateTimeToString(_venda.date);
    _descontoController.text = '${_venda.desconto}';
    _atualizaValorTotal();
  }

  void _exibirDialog(String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mensagem'),
          content: Text(mensagem),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _atualizaValorTotal() {
    final total = double.parse(
        ((_venda.quantidade * _venda.preco) - _venda.desconto)
            .toStringAsFixed(2));
    _venda = _venda.copyWith(total: total);
    _valorTotalController.text = 'R\$ $total';
  }

  void _showDatePicker() async {
    final DateTime? selectDate = await Helpers.showCustomDatePicker(context);
    if (selectDate != null) {
      _dataVendaController.text = Helpers.formatarDateTimeToString(selectDate);
    }
  }

  void _carregarDados() {
    _venda = Venda.initial(date: DateTime.now(), cliente: Cliente.initial());

    _valorTotalController = TextEditingController();
    _descontoController = TextEditingController();
    _dataVendaController = TextEditingController(
        text: Helpers.formatarDateTimeToString(_venda.date));

    _atualizaValorTotal();
  }

  @override
  void dispose() {
    _dataVendaController.dispose();
    _descontoController.dispose();
    _valorTotalController.dispose();
    super.dispose();
  }
}
