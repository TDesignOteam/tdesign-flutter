import 'package:example/pages/badge_page.dart';
import 'package:example/pages/button_page.dart';
import 'package:example/pages/checkbox_page.dart';
import 'package:example/pages/material_button_page.dart';
import 'package:example/pages/picker_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdesign/tdesign.dart';

import 'pages/button_page.dart';
import 'pages/dialog_page.dart';
import 'pages/icons_page.dart';
import 'pages/message_page.dart';
import 'pages/popup_page.dart';
import 'pages/radio_page.dart';
import 'pages/rate_page.dart';
import 'pages/switch_page.dart';
import 'pages/tags_page.dart';
import 'pages/toast_page.dart';
import 'responsive_layout/responsive_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final model = StyleModel();
    final toastBuilder = TDToast.init();
    final messageBuilder = TDMessage.init();
    final popupBuilder = Popup.init();
    return TDTheme(
      child: MaterialApp(
        title: 'TDesign Example',
        darkTheme: ThemeData.dark(),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<StyleModel>(create: (context) => model),
            ChangeNotifierProvider<HomeModel>(create: (context) => HomeModel(MyHomePage())),
            ChangeNotifierProvider<DetailModel>(create: (_) => DetailModel(null)),
            ChangeNotifierProvider<HomeAnimated>(create: (_) => HomeAnimated(model)),
            ChangeNotifierProvider<DetailAnimated>(create: (_) => DetailAnimated(model)),
          ],
          child: ResponsivePage(
            emptyWidget: Stack(
              children: [
                Center(
                  child: Text('点击左侧菜单项查看组件使用示例。'),
                ),
                Consumer<StyleModel>(
                  builder: (context, style, _) {
                    return style.fullScreen == FullScreenStyle.detail
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 70,
                              height: 80,
                              child: Center(
                                child: TextButton(
                                  child: Text('返回'),
                                  onPressed: () =>
                                      Provider.of<StyleModel>(ResponsiveConfig.key.currentContext!, listen: false)
                                          .toggleDetail(ResponsiveConfig.key.currentContext, this),
                                ),
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
              ],
            ),
          ),
        ),
        builder: (context, child) {
          child = toastBuilder(context, child);
          child = messageBuilder(context, child);
          child = popupBuilder(context, child);
          return child;
        },
      ),
    );
  }
}

void _push(BuildContext context, Widget widget) {
  DetailModel.showPage(context, widget, null);
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
    ListItem('Dialog', (context) => _push(context, DialogPage())),
    ListItem('Popup', (context) => _push(context, PopupPage())),
    ListItem('CheckBox', (context) => _push(context, CheckBoxPage())),
    ListItem('Radio', (context) => _push(context, RadioPage())),
    ListItem('Picker', (context) => _push(context, PickerPage())),
    ListItem('Switch', (context) => _push(context, SwitchPage())),
    ListItem('Button', (context) => _push(context, ButtonPage())),
    ListItem('MaterialButton', (context) => _push(context, MaterialButtonPage())),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TDColors.blue,
        title: Text('TDesign Example'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 5),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
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
          );
        },
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
