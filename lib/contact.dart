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
              SizedBox(
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
                    onPressed: () {}, icon: Icon(Icons.grid_view_rounded)),
                IconButton(onPressed: () {}, icon: Icon(Icons.list_outlined))
              ])
            ],
          )
        ],
      ),
    );
  }
}
