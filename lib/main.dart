import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Page1(),
    ),
  );
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
          child: const Text('Go!'),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {

    final textWrapper = _TextWrapper(GlobalKey<_TextWrapperState>());

    const items = <String>['汽車', '鬧鈴', '上傳雲端','博物館','禮物盒','骰子','wifi','抓寶可夢'];
    final List<IconData> icons = [Icons.airport_shuttle,Icons.alarm,Icons.backup,Icons.account_balance,
      Icons.card_giftcard,Icons.casino,Icons.wifi,Icons.catching_pokemon];

    var listView = ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) =>
          Card(
            child:ListTile(title: Text(items[index],style: TextStyle(fontSize: 20),),
              onTap: () => textWrapper.setText('點選'+items[index]),
              leading: Container(
                child: Icon(icons[index]),
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),),
              subtitle: Text('項目說明',style: TextStyle(fontSize: 16),),),
          ),

      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

    final btn = RaisedButton(
      child: Text('回到上一頁'),
      onPressed: ()=> Navigator.pop(context),
    );

    final widget = Container(
      margin: EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children:  [
          textWrapper,
          Expanded(child: listView,),
          Container(
            child: btn,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(30),
          ),
        ],
      ),
    );

    final page = Scaffold(
      appBar: AppBar(),
      body: widget,
      );
    return page;
  }
}

class _TextWrapper extends StatefulWidget {
  final GlobalKey<_TextWrapperState> _key;

  _TextWrapper(this._key): super (key: _key);

  State<StatefulWidget> createState() => _TextWrapperState();

  setText(String string) {
    _key.currentState?.setText(string);
  }
}

class _TextWrapperState extends State<_TextWrapper> {
  String _str = '';

  Widget build(BuildContext context) {
    var widget = Text(
      _str,
      style:  TextStyle(fontSize: 20),
    );

    return widget;
  }

  setText(String string) {
    setState(() {
      _str = string;
    });
  }
}