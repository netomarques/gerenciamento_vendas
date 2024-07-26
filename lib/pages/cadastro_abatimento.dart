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
  late final TextEditingController _dataAbatimentoController;
  late Size _deviceSize;
  late Venda _venda;
  late Abatimento _abatimentoForm;

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
        width: _deviceSize.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: _deviceSize.width,
              color: const Color(0xFFEB710A),
              child: const Center(
                child: Text(
                  'Cadastro de abatimento',
                  style: TextStyle(fontSize: 16, color: Color(0xFFFDFFFF)),
                ),
              ),
            ),
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
        _botaoCadastrarAbatimento('Salvar', _submitForm),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String msg = '';
      try {
        _formKey.currentState!.save();
        Abatimento abatimento = Abatimento(
            idVenda: _abatimentoForm.idVenda,
            valor: _abatimentoForm.valor,
            dateAbatimento: _abatimentoForm.dateAbatimento);
        await ref.read(abatimentoServiceProvider).salvarAbatimento(abatimento);
        ref.read(vendaProvider(_venda).notifier).getVenda();
        msg = 'Abatimento cadastrado com sucesso';
        _formKey.currentState!.reset();
        context.pop();
      } catch (e) {
        msg = 'Erro ao salvar abatimento';
      } finally {
        _exibirDialog(msg);
      }
    }
  }

  void _exibirDialog(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(msg);
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
        return 'Por favor, valor não pode \nser maior do que ${_venda.totalAberto}';
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
    _abatimentoForm = _abatimentoForm.copyWith(
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
    _abatimentoForm = _abatimentoForm.copyWith(
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
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFF3B7554),
      ),
      child: Center(
        child: Text(
          "A receber: ${_formatterMoeda.format(_venda.totalAberto!.toDouble())}",
          style: const TextStyle(color: Color(0xFFFDFFFF), fontSize: 20),
        ),
      ),
    );
  }

  _botaoCadastrarAbatimento(String text, Function acao) {
    return Center(
      child: Padding(
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
      ),
    );
  }

  _carregarDados() {
    _formatterMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    _venda = widget.venda;
    _abatimentoForm = Abatimento(
        idVenda: _venda.id!,
        valor: Decimal.zero,
        dateAbatimento: DateTime.now());
    _dataAbatimentoController = TextEditingController(
        text: Helpers.formatarDateTimeToString(_abatimentoForm.dateAbatimento));
  }

  @override
  void dispose() {
    _dataAbatimentoController.dispose();
    super.dispose();
  }
}
