import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/api/vendas_api.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:vendas_gerenciamento/utils/nav.dart';
import 'package:vendas_gerenciamento/widgets/acoes_text_button.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field2.dart';
import 'package:intl/intl.dart';

class CadastroVendaRua extends StatefulWidget {
  const CadastroVendaRua({super.key});

  @override
  State<CadastroVendaRua> createState() => _CadastroVendaRuaState();
}

class _CadastroVendaRuaState extends State<CadastroVendaRua> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _valorTotalController;
  late final TextEditingController _dataVendaController;
  late final TextEditingController _descontoController;
  late Venda _venda;
  late final Cliente _cliente;

  final DateFormat _dateFormat = DateFormat('dd/MM/yy');

  late double _largura;
  late double _altura;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    _altura = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.dashboard,
              color: Color(0xFFEB710A),
            ),
            onPressed: () {
              pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      // resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  _body() {
    return Container(
      color: const Color(0xFF006940),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _tituloForm(),
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
      ),
    );
  }

  _containerValorTotal() {
    return _containerTextForm(
      TextField(
        controller: _valorTotalController,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF006940),
        ),
        decoration: InputDecoration(
          labelText: 'Total',
          labelStyle: const TextStyle(fontSize: 14, color: Color(0xFF910029)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          filled: true,
          fillColor: const Color(0xFFFDFFFF).withOpacity(0.75),
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
    // _venda.preco = double.parse(value);
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
        // _venda.preco = double.parse(value!);
        _atualizaValorTotal();
      }
    } catch (e) {
      return 'Erro não identificado';
    }
    return null;
  }

  void _onSavedQuantidade(String value) {
    // _venda.quantidade = double.parse(value);
  }

  String? _validatorQuantidade(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe a quantidade vendida';
      }
      double.parse(value);
    } on FormatException {
      return 'Por favor, informe um valor numérico válido para a quantidade vendida';
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
        _atualizaValorTotal();
      }
    } catch (e) {
      return 'Erro não identificado';
    }

    return null;
  }

  void _onSavedData(String value) {
    final DateFormat dateFormatBanco = DateFormat('yyyy/MM/dd');

    // _venda.date =
    //     dateFormatBanco.parse(dateFormatBanco.format(_dateFormat.parse(value)));
  }

  String? _validatorData(String? value) {
    final DateFormat dateFormatBanco = DateFormat('yyyy/MM/dd');

    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe a data da venda';
      } else {
        dateFormatBanco.parse(dateFormatBanco.format(_dateFormat.parse(value)));
      }
    } catch (e) {
      return 'Por favor, verifique o formato da data da venda';
    }

    return null;
  }

  void _onSavedDesconto(String value) {
    // _venda.desconto = double.parse(value);
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
      // _venda.desconto = double.parse(value!);
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
      try {
        Venda venda = Venda(
            id: VendasApi().gerarId(),
            quantidade: _venda.quantidade,
            preco: _venda.preco,
            date: _venda.date,
            desconto: _venda.desconto,
            cliente: _venda.cliente);
        VendasApi().adicionarVenda(venda);
        _exibirDialog('Venda cadastrada com sucesso');
        _formKey.currentState!.reset();
        _limparCampos();
      } catch (e) {
        print('Erro ao salvar venda: ${e.toString().toUpperCase()}');
        _exibirDialog('Erro ao salvar venda');
      }
    }
  }

  _containerTextForm(widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, right: 32),
      child: widget,
    );
  }

  _tituloForm() {
    return Container(
      width: _largura,
      height: _altura * 0.1,
      color: const Color(0xFF910029),
      padding: const EdgeInsets.only(left: 16, top: 12),
      child: const Text(
        'Venda (Rua)',
        style: TextStyle(
          color: Color(0xFFFDFFFF),
          fontSize: 30,
        ),
      ),
    );
  }

  void _atualizaValorTotal() {
    // _valorTotalController.text = 'R\$ ${_venda.total().toStringAsFixed(2)}';
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
      _dataVendaController.text = _dateFormat.format(picked);
    }
  }

  void _carregarDados() {
    _cliente = VendasApi().clientes.values.elementAt(0);

    _venda = Venda(
      id: 0,
      quantidade: 0.0,
      preco: 0.0,
      date: DateTime.now(),
      cliente: _cliente,
      desconto: 0.0,
    );

    _valorTotalController = TextEditingController();
    _descontoController = TextEditingController();
    _dataVendaController =
        TextEditingController(text: _dateFormat.format(_venda.date));

    _atualizaValorTotal();
  }

  void _limparCampos() {
    _venda = Venda(
      id: 0,
      quantidade: 0.0,
      preco: 0.0,
      date: DateTime.now(),
      cliente: _cliente,
      desconto: 0.0,
    );
    _dataVendaController.text = _dateFormat.format(_venda.date);
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
