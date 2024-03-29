import 'dart:ui_web';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'firebase_options.dart';
import 'firestore_service.dart';
import 'root.dart';

Future<void> main() async {
  usePathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

bool auth = false;

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
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool show = true;

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'مرحباً بك في',
                          style: Theme.of(context).textTheme.titleLarge!.merge(
                              TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35)),
                        ),
                      ],
                    ),
                  ),
                  Image.asset("assits/mosq.jpeg", height: 400),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xffF1F2F7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'اسم المستخدم',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'كلمة المرور',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: show,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: UnderlineInputBorder(),
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
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                        color: Colors.orangeAccent,
                        onPressed: () async {
                          bool res = await FireStoreService().login(
                              usernameController.text, passwordController.text);
                          if (res) {
                            auth = true;
                            Navigator.pushNamed(context, '/');
                          } else {
                            auth = false;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('خطأ في اسم المستخدم او كلمة المرور'),
                            ));
                          }

                          // Navigator.pushNamed(context, '/');
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: 300,
                            child: Text(
                              'تسجيل الدخول',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .merge(TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
