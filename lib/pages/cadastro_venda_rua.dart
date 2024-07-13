import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';
import 'package:vendas_gerenciamento/widgets/acoes_text_button.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CadastroVendaRua extends ConsumerStatefulWidget {
  static CadastroVendaRua builder(BuildContext context, GoRouterState state) =>
      const CadastroVendaRua();

  const CadastroVendaRua({super.key});

  @override
  ConsumerState<CadastroVendaRua> createState() => _CadastroVendaRuaState();
}

class _CadastroVendaRuaState extends ConsumerState<CadastroVendaRua> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _valorTotalController;
  late final TextEditingController _dataVendaController;
  late final TextEditingController _descontoController;
  late Venda _venda;
  // late Size _deviceSize;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    // _deviceSize = context.devicesize;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB710A),
        title: const Text(
          'Venda (RUA)',
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
              _containerValorTotal(),
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
                        '0.00',
                        'Quantidade(Kg)',
                        TextInputType.number,
                        _validatorQuantidade,
                        _onSavedQuantidade,
                        onChanged: _onChangedQuantidade,
                      ),
                    ),
                    _containerTextForm(
                      AppTextFormField2(
                        '0.00',
                        'Preço/Kg',
                        TextInputType.number,
                        _validatorPreco,
                        _onSavedPreco,
                        onChanged: _onChangedPreco,
                      ),
                    ),
                    _containerTextForm(
                      AppTextFormField2(
                        '0.00',
                        'Desconto',
                        TextInputType.number,
                        _validatorDesconto,
                        _onSavedDesconto,
                        onChanged: _onChangedDesconto,
                        controller: _descontoController,
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

  _containerValorTotal() {
    return _containerTextForm(
      TextField(
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
      ),
    );
  }

  void _onSavedPreco(String value) {
    _venda = _venda.copyWith(preco: double.parse(value));
  }

  String? _validatorPreco(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o preço do quilo';
      } else {
        double.parse(value);
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
        _venda = _venda.copyWith(preco: double.parse(value!));
        _atualizaValorTotal();
      }
    } catch (e) {
      return 'Erro não identificado';
    }
    return null;
  }

  void _onSavedQuantidade(String value) {
    _venda = _venda.copyWith(quantidade: double.parse(value));
  }

  String? _validatorQuantidade(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe a quantidade vendida';
      }
      double.parse(value);
    } on FormatException {
      return 'Por favor, informe um valor numérico válido \npara a quantidade vendida';
    } catch (e) {
      return 'Erro ao validar Quantidade';
    }

    return null;
  }

  void _onChangedQuantidade(String value) {
    String? error = _validatorQuantidade(value);
    if (error == null) {
      _venda = _venda.copyWith(quantidade: double.parse(value));
      _atualizaValorTotal();
    }
  }

  void _onSavedData(String value) {
    _venda = _venda.copyWith(date: Helpers.stringFormatadaToDateTime(value));
  }

  String? _validatorData(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe a data da venda';
      } else {
        Helpers.stringFormatadaToDateTime(value);
      }
    } catch (e) {
      return 'Por favor, verifique o formato da data da venda';
    }

    return null;
  }

  void _onSavedDesconto(String value) {
    _venda = _venda.copyWith(desconto: double.parse(value));
  }

  String? _validatorDesconto(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o desconto';
      }

      double.parse(value);
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
      _venda = _venda.copyWith(desconto: double.parse(value!));
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
        final abatimento = Abatimento(
            idVenda: 0, valor: _venda.total!, dateAbatimento: _venda.date);
        await ref
            .read(listaVendasProvider.notifier)
            .salvarVendaRua(_venda, abatimento);

        msg = 'Venda cadastrada com sucesso';
        _formKey.currentState!.reset();
        _limparCampos();
        // if (ok == 1) {
        //   msg = 'Venda cadastrada com sucesso';
        //   _formKey.currentState!.reset();
        //   _limparCampos();
        // } else {
        //   msg = 'Venda não foi cadastrada';
        // }
      } catch (e) {
        msg = e.toString();
      } finally {
        _exibirDialog(msg);
      }
    }
  }

  _containerTextForm(widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, right: 32),
      child: widget,
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
    DateTime selectDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: selectDate,
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

    if (picked != null && picked != selectDate) {
      _dataVendaController.text = Helpers.formatarDateTimeToString(picked);
    }
  }

  void _carregarDados() {
    _venda = Venda.initial(date: DateTime.now(), cliente: Cliente.initial());

    _valorTotalController =
        TextEditingController(text: _venda.total!.toStringAsFixed(2));
    _descontoController = TextEditingController();
    _dataVendaController = TextEditingController(
        text: Helpers.formatarDateTimeToString(_venda.date));
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _valorTotalController.dispose();
    _dataVendaController.dispose();
    _descontoController.dispose();
    super.dispose();
  }
}
