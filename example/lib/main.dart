import 'package:flutter/material.dart';
import 'pages/icons_page.dart';
import 'pages/rate_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TDesign Example',
      darkTheme: ThemeData.dark(),
      home: Scaffold(appBar: AppBar(title: Text('TDesign Example')), body: SafeArea(bottom: false, child: MyHomePage()))
    );
  }
}

void _push(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ListItem<dynamic>> list = [
    ListItem('图标', (context) => _push(context, IconsPage())),
    ListItem('Rate', (context) => _push(context, RatePage())),
  ];

  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 5),
      itemCount: list.length,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        color: list[index].isSelected ? Colors.red[100] : Theme.of(context).dialogBackgroundColor,
        child: TextButton(
          onPressed: () {
            ListItem item = this.list[index];
            item.action(context);
          },
          child: ListTile(
            title: Text(list[index].data),
          ),
        ),
      ),
    );
  }
}

typedef ActionFunc = Function(BuildContext context);

class ListItem<T> {
  final ActionFunc action;
  bool isSelected = false;
  T data;
  ListItem(this.data, this.action);
}