import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("إحصائية السنة الحالية"),
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.green.withAlpha(30),
                        child: Icon(
                          Icons.tv,
                          color: Colors.green,
                        )),
                    Column(
                      children: [
                        Text("عدد الحملات"),
                        Text("25",
                            style: Theme.of(context).textTheme.titleLarge)
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.green.withAlpha(30),
                        child: Icon(
                          Icons.tv,
                          color: Colors.green,
                        )),
                    Column(
                      children: [
                        Text("عدد الحجاج"),
                        Text("25",
                            style: Theme.of(context).textTheme.titleLarge)
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.green.withAlpha(30),
                        child: Icon(
                          Icons.tv,
                          color: Colors.green,
                        )),
                    Column(
                      children: [
                        Text("عدد المشرفين"),
                        Text("25",
                            style: Theme.of(context).textTheme.titleLarge)
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Text("عدد الحجاج في الحملة"),
          Text("عدد الحملات المستفيدة"),
        ],
      ),
    );
  }
}
