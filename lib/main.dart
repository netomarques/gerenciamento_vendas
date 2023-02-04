import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/widgets/add_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: buildMaterialColor(
          const Color(0xFF006940),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Size size = const Size(0, 0);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
                //shrinkWrap: true,
                children: <Widget>[
                  Container(
                    color: const Color(0xffFDFFFF),
                    //height: size.height,
                    child: Column(
                      children: <Widget>[
                        _painel(),
                        _textoInformacao(),
                        _containerVenda(),
                        _containerVenda(),
                        _containerVenda(),
                        _containerVenda(),
                        _containerVenda(),
                        _containerVenda(),
                        _containerVenda(),
                        //_widgetOptions.elementAt(_selectedIndex),
                      ],
                    ),
                  ),
                ]),
          ),
          //_bottonNavigator(),

          // TextButton(
          //   style: TextButton.styleFrom(backgroundColor: Colors.blue),
          //   onPressed: () {},
          //   child: const Text('ADD'),
          // ),
        ],
      ),
      floatingActionButton: _bottonfloatinNavigator(),
      //bottomNavigationBar: _bottonNavigator(),
    );
  }

  _textoInformacao() {
    return Container(
      width: size.width,
      color: const Color(0xff3B7554),
      padding: const EdgeInsets.all(3.0),
      child: const Opacity(
        opacity: 0.65,
        child: Text(
          textAlign: TextAlign.center,
          'Painel de controle',
          style: TextStyle(color: Color(0xffFDFFFF), fontSize: 20),
        ),
      ),
    );
  }

  _painel() {
    return Container(
      width: size.width,
      height: size.height * 0.25,
      color: const Color(0xff910029),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _painelResumo(),
          _painelDados(),
        ],
      ),
    );
  }

  _painelResumo() {
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _painelTotal(),
          _painelFiltroData(),
        ],
      ),
    );
  }

  _painelTotal() {
    return SizedBox(
      width: size.width * 0.5,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: const Text(
              'Resumo das vendas',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: const Text(
              'R\$ 30000,00',
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
          ),
        ],
      ),
    );
  }

  _painelFiltroData() {
    return Container(
      width: size.width * 0.35,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: const Color(0xff486153),
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Text(
        '24 JAN 2023',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  _vendaData() {
    return Container(
      width: size.width * 0.26,
      height: size.height * 0.03,
      margin: const EdgeInsets.only(left: 8, top: 8),
      decoration: BoxDecoration(
        color: const Color(0xffFDFFFF),
        // border: Border.all(
        //   width: 1,
        // ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Text(
        '24 JAN 2023',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff969CAF),
        ),
      ),
    );
  }

  _vendaQuantidadePrecoPorKG() {
    return Container(
      width: size.width * 0.5,
      height: 61,
      margin: const EdgeInsets.only(left: 8, top: 8),
      child: Row(children: <Widget>[
        const Icon(
          Icons.monetization_on,
          color: Color(0xffEB710A),
          size: 60,
        ),
        Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                Text(
                  'Quant: ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xffffffff),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    'Preço/kg: ',
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ]),
        ),
        Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                Text(
                  '80 Kg',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xfffdffff),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    'R\$ 12,00',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xfffdffff),
                    ),
                  ),
                ),
              ]),
        ),
      ]),
    );
  }

  _painelDados() {
    return SizedBox(
      width: size.width,
      //padding: const EdgeInsets.all(10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _painelDadosIcon(),
          _painelDadosValorQuantidade(),
        ],
      ),
    );
  }

  _painelDadosIcon() {
    return SizedBox(
      width: size.width * 0.4,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8),
            width: size.width * 0.4 * 0.3,
            child: const Icon(
              Icons.auto_graph,
              color: Color(0xffEB710A),
              size: 36.0,
            ),
          ),
          SizedBox(
            width: size.width * 0.4 * 0.7,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 8),
                  child: const Text(
                    '04',
                    style: TextStyle(color: Color(0xfffdffff), fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 8),
                  child: const Opacity(
                    opacity: 0.5,
                    child: Text(
                      'Total de vendas',
                      style: TextStyle(color: Color(0xfffdffff), fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _painelDadosValorQuantidade() {
    return SizedBox(
      width: size.width * 0.6,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: size.width * 0.6 * 0.5,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'R\$ 21690,00',
                    style: TextStyle(color: Color(0xfffdffff), fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  //padding: const EdgeInsets.only(left: 8),
                  child: const Opacity(
                    opacity: 0.5,
                    child: Text(
                      '02 Rua',
                      style: TextStyle(color: Color(0xfffdffff), fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: size.width * 0.6 * 0.5,
            child: Column(
              children: <Widget>[
                Container(
                  //padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'R\$ 36000,00',
                    style: TextStyle(color: Color(0xfffdffff), fontSize: 16),
                  ),
                ),
                Container(
                  //padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.topLeft,
                  child: const Opacity(
                    opacity: 0.5,
                    child: Text(
                      '02 Fiados',
                      style: TextStyle(color: Color(0xfffdffff), fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _containerVenda() {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
      width: size.width,
      //height: 101,
      height: size.height * 0.155,
      color: const Color(0xff910029),
      child: Row(
        children: <Widget>[
          Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _vendaData(),
                _vendaQuantidadePrecoPorKG(),
              ]),
          _vendaValorTotal(),
        ],
      ),
    );
  }

  _vendaValorTotal() {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.only(top: 8),
      alignment: Alignment.topRight,
      child: const Text(
        "R\$ 18000,00",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }

  _bottonNavigator() {
    return Container(
      margin: const EdgeInsets.only(left: 40.0, right: 10.0),
      child: BottomNavigationBar(
          backgroundColor: const Color(0xFF006940),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'CLIENTES',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              label: 'VENDA',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'PESQUISA',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xffEB710A),
          onTap: _onItemTapped),
    );
  }

  _bottonfloatinNavigator() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF17CA84),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(right: 20),
      width: size.width * 0.8,
      padding: const EdgeInsets.all(4),
      //color: const Color(0xFF17CA84),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            tooltip: 'Increment',
            onPressed: () {},
            child: const Icon(Icons.people),
          ),
          FloatingActionButton(
            tooltip: 'Increment',
            onPressed: () {},
            child: const Icon(Icons.add_shopping_cart),
          ),
          FloatingActionButton(
            tooltip: 'Increment',
            onPressed: () {},
            child: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
