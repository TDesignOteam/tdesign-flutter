import 'package:example/pages/badge_page.dart';
import 'package:example/pages/checkbox_page.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

import 'pages/dialog_page.dart';
import 'pages/icons_page.dart';
import 'pages/message_page.dart';
import 'pages/rate_page.dart';
import 'pages/tags_page.dart';
import 'pages/toast_page.dart';
import 'pages/message_page.dart';
import 'pages/radio_page.dart';
import 'pages/switch_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final toastBuilder = Toast.init();
    final messageBuilder = Message.init();
    return TDTheme(
      child: MaterialApp(
        title: 'TDesign Example',
        darkTheme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: TDColors.blue,
            title: Text('TDesign Example'),
          ),
          body: SafeArea(
            bottom: false,
            child: MyHomePage(),
          ),
        ),
        builder: (context, child) {
          child = toastBuilder(context, child);
          child = messageBuilder(context, child);
          return child;
        },
      ),
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
    ListItem('Icon', (context) => _push(context, IconsPage())),
    ListItem('Rate', (context) => _push(context, RatePage())),
    ListItem('Badge', (context) => _push(context, BadgePage())),
    ListItem('Tags', (context) => _push(context, TagsPage())),
    ListItem('Toast', (context) => _push(context, ToastPage())),
    ListItem('Message', (context) => _push(context, MessagePage())),
    ListItem('CheckBox', (context) => _push(context, CheckBoxPage())),
    ListItem('Dialog', (context) => _push(context, DialogPage())),
    ListItem('Radio', (context) => _push(context, RadioPage())),
    ListItem('Switch', (context) => _push(context, SwitchPage())),
  ];

  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 5),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          color: list[index].isSelected
              ? Colors.red[100]
              : Theme.of(context).dialogBackgroundColor,
          child: TextButton(
            onPressed: () {
              ListItem item = this.list[index];
              item.action(context);
            },
            child: ListTile(
              title: Text(list[index].data),
            ),
          ),
        );
      },
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
