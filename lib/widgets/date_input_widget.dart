import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DateInputWidget extends StatefulWidget {
  final Function _onFunction;

  const DateInputWidget(this._onFunction, {Key? key}) : super(key: key);

  @override
  _DateInputWidgetState createState() => _DateInputWidgetState();
}

class _DateInputWidgetState extends State<DateInputWidget> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  late final TextEditingController _dateStartController;
  late final TextEditingController _dateEndController;
  late final ValueNotifier<bool> _isCheckedNotifier;
  double _largura = 0.0;
  double _altura = 0.0;

  @override
  void initState() {
    super.initState();
    _dateStartController = TextEditingController();
    _dateEndController = TextEditingController();
    _isCheckedNotifier = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    _altura = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: _largura * 0.33,
              child: Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: ElevatedButton.icon(
                  onPressed: () => validarDatas(),
                  icon: Image.asset(
                    "assets/images/find_search_icon.png",
                    height: _altura * 0.06,
                  ),
                  label: const Text(
                    "Pesquisar",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006940),
                  ),
                ),
              ),
            ),
            Container(
              width: _largura * 0.28,
              height: _altura * 0.06,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: TextField(
                controller: _dateStartController,
                decoration: InputDecoration(
                  labelText: 'Data início',
                  filled: true,
                  fillColor: const Color(0xFF006940).withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isCheckedNotifier,
              builder: (context, value, child) {
                return Visibility(
                  visible: value,
                  child: Container(
                    width: _largura * 0.28,
                    height: _altura * 0.06,
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: TextField(
                      controller: _dateEndController,
                      decoration: InputDecoration(
                        labelText: 'Data Final',
                        filled: true,
                        fillColor: const Color(0xFF006940).withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: _altura * 0.05,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isCheckedNotifier,
                  builder: (context, value, child) {
                    return Checkbox(
                      value: value,
                      onChanged: ((value) => _isCheckedNotifier.value = value!),
                    );
                  },
                ),
              ),
            ),
            const Text(
              "Intervalo de datas",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  void validarDatas() async {
    Fluttertoast.showToast(
        msg: "Função em breve!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0);
    // if (_isCheckedNotifier.value) {
    //   if (_dateStartController.text != "" && _dateEndController.text != "") {
    //     widget._onFunction(_dateStartController.text, _dateEndController.text);
    //   } else {
    //     if (_dateStartController.text != "" && _dateEndController.text == "") {
    //     } else if (_dateStartController.text == "" &&
    //         _dateEndController.text != "") {}
    //   }
    // } else {
    //   if (_dateStartController.text != "") {
    //     widget._onFunction(
    //         _dateFormat.format(DateTime(1900)), _dateStartController.text);
    //   } else {}
    // }
  }

  @override
  void dispose() {
    _dateStartController.dispose();
    _dateEndController.dispose();
    _isCheckedNotifier.dispose();
    super.dispose();
  }
}
