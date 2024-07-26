import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';
import 'package:vendas_gerenciamento/widgets/acoes_text_button.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field2.dart';

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
  late final NumberFormat _formatterMoeda;
  late final NumberFormat _formatterQuantidade;
  late final TextEditingController _valorTotalController;
  late final TextEditingController _dataVendaController;
  late Venda _venda;
  late ButtonState _buttonState;

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
    _buttonState = ref.watch(buttonProvider);

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
                          carregando: _buttonState.carregando,
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
    _venda = _venda.copyWith(preco: _stringParseDecimal(value));
  }

  String? _validatorPreco(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o preço do quilo';
      }
      final preco = _stringParseDecimal(value);
      if (preco == Decimal.zero) {
        return 'Por favor, preco não pode ser zero';
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
    if ('Por favor, preco não pode ser zero' == error) {
      error = null;
    }

    try {
      if (error != null) {
        return error;
      }
      _venda = _venda.copyWith(preco: _stringParseDecimal(value));
      _atualizaValorTotal();
    } catch (e) {
      return 'Erro não identificado';
    }
    return null;
  }

  void _onSavedQuantidade(String value) {
    _venda = _venda.copyWith(
      quantidade: Decimal.parse(
          _formatterQuantidade.parse(value.replaceAll(' kg', '')).toString()),
    );
  }

  String? _validatorQuantidade(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe a quantidade vendida';
      }
      final quantidade = Decimal.parse(
        _formatterQuantidade
            .parse(value.replaceAll(RegExp(r' kg'), ''))
            .toString(),
      );
      if (quantidade == Decimal.zero) {
        return 'Por favor, quantidade não pode ser zero';
      }
    } on FormatException {
      return 'Por favor, informe um valor numérico válido \npara a quantidade vendida';
    } catch (e) {
      return 'Erro ao validar Quantidade';
    }

    return null;
  }

  String? _onChangedQuantidade(String? value) {
    String? error = _validatorQuantidade(value);
    if ('Por favor, quantidade não pode ser zero' == error) {
      error = null;
    }

    try {
      if (error != null) {
        return error;
      }
      _venda = _venda.copyWith(
        quantidade: Decimal.parse(
          _formatterQuantidade.parse(value!.replaceAll(' kg', '')).toString(),
        ),
      );
      _atualizaValorTotal();
    } catch (e) {
      return 'Erro não identificado';
    }

    return null;
  }

  void _onSavedData(String value) {
    _venda = _venda.copyWith(date: Helpers.stringFormatadaToDateTime(value));
  }

  String? _validatorData(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe a date da venda';
      }
      Helpers.stringFormatadaToDateTime(value);
    } catch (e) {
      return 'Por favor, verifique o formato da data da venda';
    }

    return null;
  }

  void _onSavedDesconto(String value) {
    _venda = _venda.copyWith(desconto: _stringParseDecimal(value));
  }

  String? _validatorDesconto(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o desconto';
      }
      _stringParseDecimal(value);
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
      _venda = _venda.copyWith(desconto: _stringParseDecimal(value));
      _atualizaValorTotal();
    } on FormatException {
      return 'Por favor, informe um valor numérico válido para o desconto';
    } catch (e) {
      return 'Erro não identificado';
    }

    return null;
  }

  Decimal _stringParseDecimal(value) {
    return Decimal.parse(_formatterMoeda.parse(value).toString());
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String msg = '';
      try {
        ref.read(buttonProvider.notifier).setCarregando(true);
        if (_venda.cliente.id == 1) {
          msg = 'Selecione um cliente';
        } else {
          _formKey.currentState!.save();
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
        ref.read(buttonProvider.notifier).setCarregando(false);
      }
    }
  }

  void _limparCampos() {
    _venda = Venda.initial(
      date: DateTime.now(),
      cliente: Cliente.initial(),
      desconto: Decimal.zero,
      preco: Decimal.zero,
      quantidade: Decimal.zero,
      total: Decimal.zero,
    );
    _dataVendaController.text =
        Helpers.formatarDateTimeToString(_venda.date, format: 'dd/MM/yyyy');
    _atualizaValorTotal();
  }

  void _exibirDialog(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(msg);
      },
    );
  }

  void _atualizaValorTotal() {
    final total = Decimal.parse(
      ((_venda.quantidade * _venda.preco) - _venda.desconto).toStringAsFixed(2),
    );
    _venda = _venda.copyWith(total: total);
    _valorTotalController.text = _formatterMoeda.format(total.toDouble());
  }

  void _showDatePicker() async {
    final DateTime? selectDate = await Helpers.showCustomDatePicker(context);
    if (selectDate != null) {
      _dataVendaController.text =
          Helpers.formatarDateTimeToString(selectDate, format: 'dd/MM/yyyy');
    }
  }

  void _carregarDados() {
    _formatterMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    _formatterQuantidade = NumberFormat('#,##0.00', 'pt_BR');
    _venda = Venda.initial(
      date: DateTime.now(),
      cliente: Cliente.initial(),
      desconto: Decimal.zero,
      preco: Decimal.zero,
      quantidade: Decimal.zero,
      total: Decimal.zero,
    );
    _valorTotalController = TextEditingController();
    _dataVendaController = TextEditingController(
      text: Helpers.formatarDateTimeToString(_venda.date, format: 'dd/MM/yyyy'),
    );
    _atualizaValorTotal();
  }

  @override
  void dispose() {
    _dataVendaController.dispose();
    _valorTotalController.dispose();
    super.dispose();
  }
}
