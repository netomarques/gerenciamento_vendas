import 'package:flutter/material.dart';

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
        //primarySwatch: ColorSwatch(primary, _swatch) const Color(0xff006940),
        primarySwatch: buildMaterialColor(
          const Color(0xFF006940),
        ),
        scaffoldBackgroundColor: Colors.lightGreen,
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
        title: const Text('Painel de controle'),
      ),
      body: Container(
        color: Colors.white70,
        height: size.height,
        child: Column(
          children: <Widget>[
            _painel(),
            Container(
              width: size.width,
              color: Colors.green,
              padding: const EdgeInsets.all(3.0),
              child: const Text(
                textAlign: TextAlign.center,
                'Painel de controle',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            _widgetOptions.elementAt(_selectedIndex),
          ],
        ),
      ),
      bottomNavigationBar: _bottonNavigator(),
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
    return Container(
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
              'RS 30000,00',
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
        // border: Border.all(
        //   width: 1,
        // ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Text(
        '24 JAN 2023',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
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
              //color: Colors.yellow,
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
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 8),
                  child: const Text(
                    'Total de vendas',
                    style: TextStyle(color: Colors.white, fontSize: 12),
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
                    'RS 21690,00',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  //padding: const EdgeInsets.only(left: 8),
                  child: const Text(
                    '02 Rua',
                    style: TextStyle(color: Colors.white, fontSize: 12),
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
                    'RS 36000,00',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Container(
                  //padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    '02 Fiados',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _bottonNavigator() {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped);
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