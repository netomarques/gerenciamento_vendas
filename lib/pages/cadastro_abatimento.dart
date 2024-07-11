import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field2.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CadastroAbatimento extends ConsumerStatefulWidget {
  final Venda venda;

  const CadastroAbatimento(this.venda, {super.key});

  @override
  ConsumerState<CadastroAbatimento> createState() => _CadastroAbatimentoState();
}

class _CadastroAbatimentoState extends ConsumerState<CadastroAbatimento> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _textValorController;
  late final TextEditingController _dataAbatimentoController;
  late Size _deviceSize;
  late Venda _venda;
  late Abatimento _abatimento;

  @override
  void initState() {
    _venda = widget.venda;
    _textValorController = TextEditingController();
    _dataAbatimentoController = TextEditingController(
        text: Helpers.formatarDateTimeToString(DateTime.now()));
    _abatimento = Abatimento(
        idVenda: _venda.id!, valor: 0.0, dateAbatimento: DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;

    return AlertDialog(
      backgroundColor: const Color(0xFFFDFFFF),
      shape: const RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: Color(0xFF910029),
          ),
          borderRadius: BorderRadius.all(Radius.circular(26))),
      content: SizedBox(
        height: _deviceSize.height * 0.35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _textTotalAReceber(),
            Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _containerTextForm(
                      AppTextFormField2(
                        '0.0',
                        'Valor do abatimento',
                        TextInputType.number,
                        _validatorValor,
                        _onSavedValor,
                        controller: _textValorController,
                      ),
                    ),
                    _containerTextForm(
                      AppTextFormField2(
                        '01/01/01',
                        'Data do abatimneto',
                        TextInputType.datetime,
                        _validatorData,
                        _onSavedData,
                        onTap: _showDatePicker,
                        controller: _dataAbatimentoController,
                        isReadOnly: true,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            _botaoCadastrarAbatimento('Salvar', _submitForm),
            _botaoCadastrarAbatimento('Cancelar', context.pop),
          ],
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        _formKey.currentState!.save();
        ref.read(abatimentoServiceProvider).salvarAbatimento(_abatimento);
        context.pop();
        ref.read(vendaProvider(_venda.id!).notifier).getVenda(_venda.id!);
        _exibirDialog('Abatimento salvo');
      } catch (e) {
        _formKey.currentState!.reset();
        _exibirDialog('Erro ao salvar abatimento');
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

  _containerTextForm(widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, right: 32),
      child: widget,
    );
  }

  String? _validatorValor(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe o valor';
      }

      final valor = double.parse(value);
      if (valor > double.parse(_venda.totalAberto!.toStringAsFixed(2))) {
        return 'Por favor, valor não pode ser \nmaior do que ${_venda.totalAberto}';
      }

      if (valor <= 0) {
        return 'Por favor, valor não pode ser 0';
      }
    } on FormatException {
      return 'Por favor, informe um valor \nnumérico válido para o valor';
    } catch (e) {
      return 'Erro ao validar valor';
    }

    return null;
  }

  void _onSavedValor(String value) {
    _abatimento = _abatimento.copyWith(valor: double.parse(value));
  }

  String? _validatorData(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Por favor, informe a date da venda';
      }

      Helpers.stringFormatadaToDateTime(value);
    } catch (e) {
      return 'Por favor, verifique o formato da date da venda';
    }

    return null;
  }

  void _onSavedData(String value) {
    _abatimento = _abatimento.copyWith(
        dateAbatimento: Helpers.stringFormatadaToDateTime(value));
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
      _dataAbatimentoController.text = Helpers.formatarDateTimeToString(picked);
    }
  }

  _textTotalAReceber() {
    return Container(
      height: _deviceSize.height * 0.07,
      color: const Color(0xFF3B7554),
      padding: const EdgeInsets.all(3.0),
      child: Opacity(
        opacity: 0.65,
        child: Center(
          child: Text(
            "A receber: R\$ ${_venda.totalAberto!.toStringAsFixed(2)}",
            style: const TextStyle(color: Color(0xFFFDFFFF), fontSize: 20),
          ),
        ),
      ),
    );
  }

  _botaoCadastrarAbatimento(String text, Function acao) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, right: 8),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: _deviceSize.width * 0.01),
        width: _deviceSize.width * 0.25,
        height: _deviceSize.height * 0.05,
        decoration: BoxDecoration(
          color: const Color(0xFFEB710A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () => acao(),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFFDFFFF),
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textValorController.dispose();
    _dataAbatimentoController.dispose();
    super.dispose();
  }
}
