import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendas_gerenciamento/api/vendas_api.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';
import 'package:vendas_gerenciamento/utils/nav.dart';
import 'package:vendas_gerenciamento/utils/telefone_formato.dart';
import 'package:vendas_gerenciamento/widgets/acoes_text_button.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field2.dart';
import 'package:intl/intl.dart';

class CadastroCliente extends StatefulWidget {
  const CadastroCliente({super.key});

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _textNomeController;
  late final TextEditingController _numTelefoneController;
  late final TextEditingController _numCpfController;
  late Cliente _cliente;

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
                        ),
                      ),
                      _containerTextForm(
                        AppTextFormField2(
                          'Informe o telefone',
                          'Telefone',
                          TextInputType.number,
                          _validatorTelefone,
                          _onSavedTelefone,
                          formato: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneFormato(),
                          ],
                        ),
                      ),
                      _containerTextForm(
                        AppTextFormField2(
                          'Informe o CPF',
                          'CPF',
                          TextInputType.number,
                          _validatorCpf,
                          _onSavedCpf,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60, bottom: 8),
                          child: AcoesTextButton(
                            onFunction: _submitForm,
                            text: 'Cadastrar Cliente',
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
        'Cadastro de Cliente',
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
    _cliente.nome = value;
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
    _cliente.telefone = value;
  }

  String? _validatorTelefone(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o telefone';
      }

      int qtdeNumeroTelefone =
          value.replaceAll(RegExp('[^0-9a-zA-Z]+'), '').length;
      if ((qtdeNumeroTelefone != 10 && qtdeNumeroTelefone != 11)) {
        return 'Telefone incorreto, deve conter 10 ou 11 números';
      }
    } catch (e) {
      return 'erro não identificado';
    }

    return null;
  }

  void _onSavedCpf(String value) {
    _cliente.cpf = value;
  }

  String? _validatorCpf(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o CPF';
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
        Cliente cliente = Cliente(
            id: VendasApi().gerarIdCliente(),
            nome: _cliente.nome,
            telefone: _cliente.telefone);
        VendasApi().adicionarCliente(cliente);
        _exibirDialog('Cliente cadastrado com sucesso');
        _formKey.currentState!.reset();
        _limparCampos();
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

  void _limparCampos() {
    _cliente = Cliente(id: 0, nome: "nome", telefone: "92999999999");

    _textNomeController.text = _cliente.nome;
    _numTelefoneController.text = _cliente.telefone;
    _numCpfController.text = _cliente.cpf;
  }

  void _carregarDados() {
    _cliente = Cliente(id: 0, nome: "nome", telefone: "92999999999");

    _textNomeController = TextEditingController();
    _numTelefoneController = TextEditingController();
    _numCpfController = TextEditingController();
  }
}
