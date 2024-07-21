import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';
import 'package:vendas_gerenciamento/widgets/acoes_text_button.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field2.dart';

class AlterarCliente extends ConsumerStatefulWidget {
  final int idCliente;

  static AlterarCliente builder(BuildContext context, GoRouterState state) =>
      AlterarCliente(state.extra as int);

  const AlterarCliente(this.idCliente, {super.key});

  @override
  ConsumerState<AlterarCliente> createState() => _AlterarClienteState();
}

class _AlterarClienteState extends ConsumerState<AlterarCliente> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _textNomeController;
  late final TextEditingController _textTelefoneController;
  late final TextEditingController _textCpfController;
  late Cliente _clienteAtualizado;
  late ClienteAtualNotifier _clienteAtualNotifier;
  late final int _idCliente;
  late ButtonState _buttonState;
  late Size _deviceSize;

  @override
  void initState() {
    _idCliente = widget.idCliente;
    _clienteAtualNotifier =
        ref.read(clienteAtualProvider(widget.idCliente).notifier);
    _carregarDados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _buttonState = ref.watch(buttonProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB710A),
        title: const Text(
          'Atualizar dados do cliente',
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
                          carregando: _buttonState.carregando,
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
    );
  }

  _tituloForm() {
    return Container(
      width: _deviceSize.width,
      height: _deviceSize.height * 0.1,
      color: const Color(0xFFEB710A),
      padding: const EdgeInsets.only(left: 16, top: 12),
      child: Text(
        ref.watch(clienteAtualProvider(widget.idCliente)).cliente!.nome,
        style: const TextStyle(
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
    _clienteAtualizado = _clienteAtualizado.copyWith(nome: value);
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
    _clienteAtualizado = _clienteAtualizado.copyWith(
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
    _clienteAtualizado = _clienteAtualizado.copyWith(
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
        _clienteAtualNotifier.atualizarCliente(_clienteAtualizado);
        _exibirDialog('Cliente atualizado com sucesso');
        //_limparCampos();
      } catch (e) {
        _formKey.currentState!.reset();
        print('Erro ao atualizar cliente: ${e.toString().toUpperCase()}');
        _exibirDialog('Erro ao atualizar cliente');
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
              onPressed: () => context.pop(),
            ),
          ],
        );
      },
    );
  }

  void _carregarDados() async {
    _textNomeController = TextEditingController();
    _textTelefoneController = TextEditingController();
    _textCpfController = TextEditingController();

    _clienteAtualizado =
        await ref.read(clienteServiceProvider).getClienteId(_idCliente);

    _textNomeController.text = _clienteAtualizado.nome;
    _textTelefoneController.text =
        _formatarCampo(_clienteAtualizado.telefone, TelefoneFormato());
    _textCpfController.text = _formatarCampo(_clienteAtualizado.cpf,
        CpfOuCnpjFormato([CpfFormato(), CnpjFormato()]));
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
