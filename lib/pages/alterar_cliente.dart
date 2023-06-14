import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendas_gerenciamento/api/vendas_api.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';
import 'package:vendas_gerenciamento/pages/formatters/cnpj_formato.dart';
import 'package:vendas_gerenciamento/pages/formatters/cpf_formato.dart';
import 'package:vendas_gerenciamento/pages/formatters/cpf_ou_cnpj_formato.dart';
import 'package:vendas_gerenciamento/pages/formatters/telefone_formato.dart';
import 'package:vendas_gerenciamento/utils/nav.dart';
import 'package:vendas_gerenciamento/widgets/acoes_text_button.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field2.dart';

class AlterarCliente extends StatefulWidget {
  final Cliente _cliente;
  const AlterarCliente(this._cliente, {super.key});

  @override
  State<AlterarCliente> createState() => _AlterarClienteState();
}

class _AlterarClienteState extends State<AlterarCliente> {
  final _formKey = GlobalKey<FormState>();
  late Cliente _clienteAlterado;
  late TextEditingController _textNomeController;
  late final TextEditingController _textTelefoneController;
  late final TextEditingController _textCpfController;

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
          )
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _containerTextForm(
                        AppTextFormField2(
                          'Informe o nome',
                          'Nome',
                          TextInputType.text,
                          _validatorNome,
                          _onSavedNome,
                          controller: _textNomeController,
                        ),
                      ),
                      _containerTextForm(
                        AppTextFormField2(
                          'Informe o telefone',
                          'Telefone',
                          TextInputType.number,
                          _validatorTelefone,
                          _onSavedTelefone,
                          controller: _textTelefoneController,
                          formato: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneFormato(),
                          ],
                        ),
                      ),
                      _containerTextForm(
                        AppTextFormField2(
                          'Informe o CPF/CNPJ',
                          'CPF/CNPJ',
                          TextInputType.number,
                          _validatorCpf,
                          _onSavedCpf,
                          controller: _textCpfController,
                          formato: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfOuCnpjFormato([CpfFormato(), CnpjFormato()]),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60, bottom: 8),
                          child: AcoesTextButton(
                            onFunction: _submitForm,
                            text: 'Salvar modificação',
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

  _tituloForm() {
    return Container(
      width: _largura,
      height: _altura * 0.1,
      color: const Color(0xff910029),
      padding: const EdgeInsets.only(left: 16, top: 12),
      child: const Text(
        'Alterar Cliente',
        style: TextStyle(
          color: Color(0xffFDFFFF),
          fontSize: 30,
        ),
      ),
    );
  }

  _containerTextForm(widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, right: 32),
      child: widget,
    );
  }

  void _onSavedNome(String value) {
    _clienteAlterado.nome = value;
  }

  String? _validatorNome(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o nome';
      }
    } catch (e) {
      return 'erro não identificado';
    }

    return null;
  }

  void _onSavedTelefone(String value) {
    _clienteAlterado.telefone = value.replaceAll(RegExp('[^0-9a-zA-Z]+'), '');
  }

  String? _validatorTelefone(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o telefone';
      }

      int qtdeNumeroTelefone =
          value.replaceAll(RegExp('[^0-9a-zA-Z]+'), '').length;
      if ((qtdeNumeroTelefone != 10 && qtdeNumeroTelefone != 11)) {
        return 'Telefone deve ter 10 ou 11 números';
      }
    } catch (e) {
      return 'erro não identificado';
    }

    return null;
  }

  void _onSavedCpf(String value) {
    _clienteAlterado.cpf = value.replaceAll(RegExp('[^0-9a-zA-Z]+'), '');
  }

  String? _validatorCpf(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o CPF';
      }

      int qtdeNumeroCpfOuCnpj =
          value.replaceAll(RegExp('[^0-9a-zA-Z]+'), '').length;
      if ((qtdeNumeroCpfOuCnpj != 11 && qtdeNumeroCpfOuCnpj != 14)) {
        return 'CPF deve ter 11 números ou CNPJ 14 números';
      }
    } catch (e) {
      return 'erro não identificado';
    }

    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        _formKey.currentState!.save();
        widget._cliente.nome = _clienteAlterado.nome;
        widget._cliente.telefone = _clienteAlterado.telefone;
        widget._cliente.cpf = _clienteAlterado.cpf;
        VendasApi().alterarCliente(widget._cliente);
        _exibirDialog('Cliente alterado com sucesso');
        _formKey.currentState!.reset();
        //_limparCampos();
      } catch (e) {
        print('Erro ao cadastrar cliente: ${e.toString().toUpperCase()}');
        _exibirDialog('Erro ao cadastrar cliente');
      }
    }
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

  void _carregarDados() {
    _clienteAlterado = Cliente(
        id: widget._cliente.id,
        nome: widget._cliente.nome,
        telefone: widget._cliente.telefone,
        cpf: widget._cliente.cpf);

    _textNomeController = TextEditingController(text: _clienteAlterado.nome);
    _textTelefoneController = TextEditingController(
        text: _formatarCampo(_clienteAlterado.telefone, TelefoneFormato()));
    _textCpfController = TextEditingController(
        text: _formatarCampo(_clienteAlterado.cpf,
            CpfOuCnpjFormato([CpfFormato(), CnpjFormato()])));
  }

  //Formatar campos ao carregar dados
  String _formatarCampo(String text, TextInputFormatter formato) {
    return formato
        .formatEditUpdate(
            TextEditingValue(text: text), TextEditingValue(text: text))
        .text;
  }

  @override
  void dispose() {
    _textCpfController.dispose();
    _textTelefoneController.dispose();
    _textNomeController.dispose();
    super.dispose();
  }
}
