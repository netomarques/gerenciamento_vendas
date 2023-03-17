import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/widgets/acoes_text_button.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field.dart';

class CadastroVendaFiado extends StatefulWidget {
  const CadastroVendaFiado({super.key});

  @override
  State<CadastroVendaFiado> createState() => _CadastroVendaFiadoState();
}

class _CadastroVendaFiadoState extends State<CadastroVendaFiado> {
  Size size = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      resizeToAvoidBottomInset: false,
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
                _containerText(
                    const AppTextFormField("Paula Tejano", "Cliente")),
                _containerText(
                    const AppTextFormField("Informe o valor", "Valor R\$")),
                _containerText(
                    const AppTextFormField("Informe o data", "Data da venda")),
                _containerText(const AppTextFormField(
                    "Informe a quantidade", "Quantidade (Kg)")),
                _containerText(
                    const AppTextFormField("Informe o preço/Kg", "Preço/Kg")),
                Container(
                  margin: const EdgeInsets.only(
                      top: 60, left: 24, right: 24, bottom: 8),
                  child: AcoesTextButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _containerText(widget) {
    return Container(
      height: size.height * 0.075,
      margin: const EdgeInsets.only(left: 16, top: 20, right: 32),
      child: widget,
    );
  }

  _tituloForm() {
    return Container(
      width: size.width,
      height: size.height * 0.1,
      color: const Color(0xff910029),
      padding: const EdgeInsets.only(left: 16, top: 12),
      child: const Text(
        'Venda (Fiado)',
        style: TextStyle(
          color: Color(0xffFDFFFF),
          fontSize: 30,
        ),
      ),
    );
  }
}
