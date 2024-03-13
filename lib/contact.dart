import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "ابحث هنا",
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Row(children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.grid_view_rounded)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.list_outlined))
              ])
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.extent(
              primary: false,
              padding: const EdgeInsets.all(40),
              crossAxisSpacing: 50,
              mainAxisSpacing: 50,
              // crossAxisCount: 3,
              maxCrossAxisExtent: 300,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green.withAlpha(30),
                        child: Icon(
                          Icons.flag,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "حملة النور",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "المملكة العربية السعودية",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple.withAlpha(30),
                          child: Icon(
                            Icons.call,
                            color: Colors.purple,
                          ),
                        ),
                        title: Text(
                          "+966 571718153",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple.withAlpha(30),
                          child: Icon(Icons.email, color: Colors.purple),
                        ),
                        title: Text(
                          "email@email.com",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green.withAlpha(30),
                        child: Icon(
                          Icons.flag,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "حملة النور",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "المملكة العربية السعودية",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple.withAlpha(30),
                          child: Icon(
                            Icons.call,
                            color: Colors.purple,
                          ),
                        ),
                        title: Text(
                          "+966 571718153",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple.withAlpha(30),
                          child: Icon(Icons.email, color: Colors.purple),
                        ),
                        title: Text(
                          "email@email.com",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green.withAlpha(30),
                        child: Icon(
                          Icons.flag,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "حملة النور",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "المملكة العربية السعودية",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple.withAlpha(30),
                          child: Icon(
                            Icons.call,
                            color: Colors.purple,
                          ),
                        ),
                        title: Text(
                          "+966 571718153",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple.withAlpha(30),
                          child: Icon(Icons.email, color: Colors.purple),
                        ),
                        title: Text(
                          "email@email.com",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green.withAlpha(30),
                        child: Icon(
                          Icons.flag,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "حملة النور",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "المملكة العربية السعودية",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple.withAlpha(30),
                          child: Icon(
                            Icons.call,
                            color: Colors.purple,
                          ),
                        ),
                        title: Text(
                          "+966 571718153",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple.withAlpha(30),
                          child: Icon(Icons.email, color: Colors.purple),
                        ),
                        title: Text(
                          "email@email.com",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green.withAlpha(30),
                        child: Icon(
                          Icons.flag,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "حملة النور",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "المملكة العربية السعودية",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple.withAlpha(30),
                          child: Icon(
                            Icons.call,
                            color: Colors.purple,
                          ),
                        ),
                        title: Text(
                          "+966 571718153",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple.withAlpha(30),
                          child: Icon(Icons.email, color: Colors.purple),
                        ),
                        title: Text(
                          "email@email.com",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
