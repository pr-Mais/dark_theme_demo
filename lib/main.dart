import 'package:dark_theme_demo/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(),
      child: CustomMaterialApp(),
    );
  }
}

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Dark Theme Demo',
      themeMode: themeChanger.getTheme,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Dark Theme Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String groupValue = 'light_mode';

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              bottom: 50,
            ),
            child: AnimatedCrossFade(
              crossFadeState: Theme.of(context).brightness == Brightness.light
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Image.asset(
                'assets/sun.png',
                width: 200,
              ),
              secondChild: Image.asset(
                'assets/moon.png',
                width: 200,
              ),
              duration: Duration(milliseconds: 200),
            ),
          ),
          RadioListTile(
            title: Text('Light Mode'),
            groupValue: groupValue,
            value: 'light_mode',
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
              themeChanger.setTheme(ThemeMode.light);
            },
          ),
          RadioListTile(
            title: Text('Dark Mode'),
            groupValue: groupValue,
            value: 'dark_mode',
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
              themeChanger.setTheme(ThemeMode.dark);
            },
          ),
          RadioListTile(
            title: Text('System Mode'),
            groupValue: groupValue,
            value: 'system_mode',
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
              themeChanger.setTheme(ThemeMode.system);
            },
          ),
        ],
      ),
    );
  }
}
