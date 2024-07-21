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
import 'package:vendas_gerenciamento/widgets/app_text_form_field2.dart';

class CadastroAbatimento extends ConsumerStatefulWidget {
  final Venda venda;

  const CadastroAbatimento(this.venda, {super.key});

  @override
  ConsumerState<CadastroAbatimento> createState() => _CadastroAbatimentoState();
}

class _CadastroAbatimentoState extends ConsumerState<CadastroAbatimento> {
  final _formKey = GlobalKey<FormState>();
  late final NumberFormat _formatterMoeda;
  // late final TextEditingController _textValorController;
  late final TextEditingController _dataAbatimentoController;
  late Size _deviceSize;
  late Venda _venda;
  late Abatimento _abatimento;

  @override
  void initState() {
    _carregarDados();
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
                        'R\$ 0.00',
                        'Valor do abatimento',
                        TextInputType.number,
                        _validatorValor,
                        _onSavedValor,
                        // controller: _textValorController,
                        formato: [
                          FilteringTextInputFormatter.digitsOnly,
                          MoedaFormato()
                        ],
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
      String msg = '';
      try {
        _formKey.currentState!.save();
        await ref.read(abatimentoServiceProvider).salvarAbatimento(_abatimento);
        ref.read(vendaProvider(_venda).notifier).getVenda();
        // _exibirDialog('Abatimento salvo');
        msg = 'Abatimento cadastrado com sucesso';
        _formKey.currentState!.reset();
        context.pop();
      } catch (e) {
        // _exibirDialog('Erro ao salvar abatimento');
        msg = 'Erro ao salvar abatimento';
      } finally {
        _exibirDialog(msg);
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

      final valor = Decimal.parse(_formatterMoeda.parse(value).toString());
      if (valor > _venda.totalAberto!) {
        return 'Por favor, valor não pode ser \nmaior do que ${_venda.totalAberto}';
      }

      if (valor <= Decimal.zero) {
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
    _abatimento = _abatimento.copyWith(
      valor: Decimal.parse(_formatterMoeda.parse(value).toString()),
    );
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
    final DateTime? selectDate = await Helpers.showCustomDatePicker(context);
    if (selectDate != null) {
      _dataAbatimentoController.text =
          Helpers.formatarDateTimeToString(selectDate);
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
            "A receber: R\$ ${_venda.totalAberto!}",
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

  _carregarDados() {
    _formatterMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    _venda = widget.venda;
    // _textValorController = TextEditingController();
    _dataAbatimentoController = TextEditingController(
        text: Helpers.formatarDateTimeToString(DateTime.now()));
    _abatimento = Abatimento(
        idVenda: _venda.id!,
        valor: Decimal.zero,
        dateAbatimento: DateTime.now());
  }

  @override
  void dispose() {
    // _textValorController.dispose();
    _dataAbatimentoController.dispose();
    super.dispose();
  }
}
