import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/widgets/acoes_text_button.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field2.dart';

class CadastroCliente extends ConsumerStatefulWidget {
  static CadastroCliente builder(BuildContext context, GoRouterState state) =>
      const CadastroCliente();

  const CadastroCliente({super.key});

  @override
  ConsumerState<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends ConsumerState<CadastroCliente> {
  final _formKey = GlobalKey<FormState>();
  // late final TextEditingController _textNomeController;
  // late final TextEditingController _textTelefoneController;
  // late final TextEditingController _textCpfController;
  late Cliente _clienteForm;
  late ButtonState _buttonState;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    _buttonState = ref.watch(buttonProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB710A),
        title: const Text(
          'Cadastro de Cliente',
          style: TextStyle(
            color: Color(0xFFFDFFFF),
          ),
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
                        'Informe o CPF/CNPJ',
                        'CPF/CNPJ',
                        TextInputType.number,
                        _validatorCpf,
                        _onSavedCpf,
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
                          carregando: _buttonState.carregando,
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
    );
  }

  _containerTextForm(widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, right: 32),
      child: widget,
    );
  }

  void _onSavedNome(String value) {
    _clienteForm = _clienteForm.copyWith(nome: value);
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
    _clienteForm = _clienteForm.copyWith(
        telefone: value.replaceAll(RegExp('[^0-9a-zA-Z]+'), ''));
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
    _clienteForm = _clienteForm.copyWith(
        cpf: value.replaceAll(RegExp('[^0-9a-zA-Z]+'), ''));
  }

  String? _validatorCpf(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o CPF';
      }

      int qtdeNumeroCpfOuCnpj =
          value.replaceAll(RegExp('[^0-9a-zA-Z]+'), '').length;
      if ((qtdeNumeroCpfOuCnpj != 11 && qtdeNumeroCpfOuCnpj != 14)) {
        return 'CPF deve ter 11 números \nou CNPJ 14 números';
      }
    } catch (e) {
      return 'erro não identificado';
    }

    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String msg = '';
      try {
        ref.read(buttonProvider.notifier).setCarregando(true);
        _formKey.currentState!.save();
        final cliente = Cliente(
          nome: _clienteForm.nome,
          telefone: _clienteForm.telefone,
          cpf: _clienteForm.cpf,
        );
        await ref.read(clienteServiceProvider).salvarCliente(cliente);
        msg = 'Cliente cadastrado com sucesso';
        _formKey.currentState!.reset();
        _limparCampos();
      } catch (e) {
        msg = e.toString();
      } finally {
        _exibirDialog(msg);
        ref.read(buttonProvider.notifier).setCarregando(false);
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
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _limparCampos() {
    // _clienteForm = Cliente(nome: "", telefone: "");
    _clienteForm = Cliente.initial();

    // _textNomeController.text = _clienteForm.nome;
    // _textTelefoneController.text = _clienteForm.telefone;
    // _textCpfController.text = _clienteForm.cpf;
    // _textNomeController.text = '';
    // _textTelefoneController.text = '';
    // _textCpfController.text = '';
  }

  void _carregarDados() {
    // _clienteForm = Cliente(nome: "", telefone: "");
    _clienteForm = Cliente.initial();

    // _textNomeController = TextEditingController();
    // _textTelefoneController = TextEditingController();
    // _textCpfController = TextEditingController();
  }

  @override
  void dispose() {
    // _textNomeController.dispose();
    // _textTelefoneController.dispose();
    // _textCpfController.dispose();
    super.dispose();
  }
}
