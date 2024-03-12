import 'package:flutter/material.dart';
import 'package:pro/contact.dart';

import 'home.dart';
import 'main.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  Widget body = HomeScreen();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Row(children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "مُـيسـّـر",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    style: ListTileStyle.drawer,
                    selectedTileColor: Colors.blue.withAlpha(30),
                    selected: index == 0,
                    onTap: () {
                      setState(() {
                        body = HomeScreen();
                        index = 0;
                      });
                    },
                    leading: Icon(Icons.home),
                    title: Text("الصفحة الرئيسية"),
                  ),
                  ListTile(
                    style: ListTileStyle.drawer,
                    selectedTileColor: Colors.blue.withAlpha(30),
                    selected: index == 1,
                    onTap: () {
                      setState(() {
                        body = Container();
                        index = 1;
                      });
                    },
                    leading: Icon(Icons.table_view),
                    title: Text("إنشاء / ادارة حسابات الحملات"),
                  ),
                  ListTile(
                    style: ListTileStyle.drawer,
                    selectedTileColor: Colors.blue.withAlpha(30),
                    selected: index == 2,
                    onTap: () {
                      setState(() {
                        body = ContactScreen();
                        index = 2;
                      });
                    },
                    leading: Icon(Icons.wifi_calling),
                    title: Text("التواصل مع الحملة"),
                  ),
                  ListTile(
                    style: ListTileStyle.drawer,
                    selectedTileColor: Colors.blue.withAlpha(30),
                    selected: index == 3,
                    onTap: () {
                      setState(() {
                        body = Container();
                        index = 3;
                      });
                    },
                    leading: Icon(Icons.person),
                    title: Text("الملف الشخصي"),
                  ),
                  ListTile(
                    style: ListTileStyle.drawer,
                    selectedTileColor: Colors.blue.withAlpha(30),
                    selected: index == 4,
                    onTap: () {
                      setState(() {
                        body = Container();
                        index = 4;
                      });
                    },
                    leading: Icon(Icons.settings),
                    title: Text("الاعدادات"),
                  ),
                ],
              )),
          Expanded(flex: 5, child: body),
        ]),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (!auth) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamed(context, '/login');
      });
    }
  }
}
