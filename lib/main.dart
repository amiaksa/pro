import 'dart:ui_web';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'root.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

bool auth = true;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: Locale('ar', 'AE'),
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
      ],

      routes: {
        '/': (context) {
          return const RootView();
        },
        '/login': (context) =>
            const MyHomePage(title: 'Flutter Demo Home Page'),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.mosque, size: 100),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'اسم المستخدم',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextFormField(),
                  Text(
                    'كلمة المرور',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextFormField(
                    obscureText: show,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye),
                      color: Colors.black,
                    )),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        auth = true;
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text('تسجيل الدخول')),
                ],
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
