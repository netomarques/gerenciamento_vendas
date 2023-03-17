import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/widgets/acoes_text_button.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field.dart';

class CadastroCliente extends StatefulWidget {
  const CadastroCliente({super.key});

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
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
                    const AppTextFormField("Informe o nome", "Nome")),
                _containerText(
                    const AppTextFormField("Informe o Telefone", "Telefone")),
                _containerText(const AppTextFormField("Informe o CPF", "CPF")),
                Container(
                  margin: const EdgeInsets.only(
                      top: 134, left: 24, right: 24, bottom: 8),
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
        'Cadastro de Cliente',
        style: TextStyle(
          color: Color(0xffFDFFFF),
          fontSize: 30,
        ),
      ),
    );
  }
}
