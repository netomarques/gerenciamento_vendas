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
  final Cliente cliente;

  static AlterarCliente builder(BuildContext context, GoRouterState state) =>
      AlterarCliente(state.extra as Cliente);

  const AlterarCliente(this.cliente, {super.key});

  @override
  ConsumerState<AlterarCliente> createState() => _AlterarClienteState();
}

class _AlterarClienteState extends ConsumerState<AlterarCliente> {
  final _formKey = GlobalKey<FormState>();
  late Cliente _clienteForm;
  late ClienteAtualState _clienteAtualState;
  late ClienteAtualNotifier _clienteNotifier;
  late ButtonState _buttonState;
  late Size _deviceSize;

  @override
  void initState() {
    _carregarDados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _clienteAtualState = ref.watch(clienteAtualProvider(widget.cliente));
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
              _clienteAtualState.carregando
                  ? const Center(child: CircularProgressIndicator())
                  : Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _containerTextForm(
                            AppTextFormField2(
                              initialValue: _clienteAtualState.cliente!.nome,
                              'Informe o nome',
                              'Nome',
                              TextInputType.text,
                              _validatorNome,
                              _onSavedNome,
                            ),
                          ),
                          _containerTextForm(
                            AppTextFormField2(
                              initialValue: _formatarTelefone(
                                  _clienteAtualState.cliente!.telefone),
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
                              initialValue: _formatarCpfCnpj(
                                  _clienteAtualState.cliente!.cpf),
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
                              padding:
                                  const EdgeInsets.only(top: 60, bottom: 8),
                              child: AcoesTextButton(
                                onFunction: _submitForm,
                                carregando: _buttonState.carregando,
                                text: 'Atualizar Cliente',
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
        _clienteAtualState.cliente!.nome,
        style: const TextStyle(
          color: Color(0xFFFDFFFF),
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
        return 'CPF deve ter 11 números ou CNPJ 14 números';
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
          id: _clienteForm.id,
          nome: _clienteForm.nome,
          telefone: _clienteForm.telefone,
          cpf: _clienteForm.cpf,
        );
        await _clienteNotifier.atualizarCliente(cliente);
        msg = 'Cliente atualizado com sucesso';
      } catch (e) {
        _formKey.currentState!.reset();
        msg = 'Erro ao atualizar cliente';
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
              onPressed: () => context.pop(),
            ),
          ],
        );
      },
    );
  }

  String _formatarTelefone(String telefone) {
    final telefoneFormatado = StringBuffer();

    telefoneFormatado.write('(${telefone.substring(0, 2)}) ');

    if (telefone.length == 11) {
      telefoneFormatado.write('${telefone.substring(2, 7)}-');
      telefoneFormatado.write(telefone.substring(7));
    } else {
      telefoneFormatado.write('${telefone.substring(2, 6)}-');
      telefoneFormatado.write(telefone.substring(6));
    }

    return telefoneFormatado.toString();
  }

  String _formatarCpfCnpj(String cpf) {
    final newText = StringBuffer();

    if (cpf.length == 11) {
      newText.write(
          '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}');
    } else {
      newText.write(
          '${cpf.substring(0, 2)}.${cpf.substring(2, 5)}.${cpf.substring(5, 8)}/${cpf.substring(8, 12)}-${cpf.substring(12)}');
    }

    return newText.toString();
  }

  void _carregarDados() async {
    _clienteNotifier = ref.read(clienteAtualProvider(widget.cliente).notifier);
    _clienteForm = Cliente.initial(id: widget.cliente.id);
  }
}
