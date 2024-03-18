import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create.dart';
import 'firestore_service.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<CampaignModel> campaigns = [];
  List<CampaignModel> campaignsOrg = [];
  TextEditingController searchController = TextEditingController();
  bool grid = true;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        campaigns = campaignsOrg
            .where((element) =>
                element.name!.toLowerCase().contains(searchController.text))
            .toList();
      } else {
        campaigns = campaignsOrg;
      }
      setState(() {});
    });
    getCampaigns();
  }

  getCampaigns() async {
    FireStoreService fireStoreService = FireStoreService();
    campaigns = await fireStoreService.getAllCampaign(true);
    campaignsOrg.clear();
    campaignsOrg.addAll(campaigns);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "ابحث هنا",
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Row(children: [
                  IconButton(
                      onPressed: () {
                        grid = true;
                        setState(() {});
                      },
                      icon: const Icon(Icons.grid_view_rounded)),
                  IconButton(
                      onPressed: () {
                        grid = false;
                        setState(() {});
                      },
                      icon: const Icon(Icons.list_outlined))
                ])
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          grid
              ? Expanded(
                  child: GridView.extent(
                    primary: false,
                    padding: const EdgeInsets.all(40),
                    crossAxisSpacing: 50,
                    mainAxisSpacing: 50,
                    // crossAxisCount: 3,
                    maxCrossAxisExtent: 400,
                    children: campaigns.map((campaign) {
                      return Container(
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
                              child: campaign.country != null
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(countries
                                          .firstWhere((element2) =>
                                              element2.code == campaign.country)
                                          .icon),
                                    )
                                  : Icon(
                                      Icons.flag,
                                      color: Colors.white,
                                    ),
                            ),
                            Text(
                              campaign.name ?? "",
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
                                campaign.phone ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.purple.withAlpha(30),
                                child: Icon(Icons.email, color: Colors.purple),
                              ),
                              title: Text(
                                campaign.email ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              : Expanded(
                  child: Column(
                    children: campaigns
                        .map((element) => Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.teal.withAlpha(50)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green,
                                      child: element.country != null
                                          ? CircleAvatar(
                                              // radius: 50,
                                              backgroundImage: AssetImage(
                                                  countries
                                                      .firstWhere((element2) =>
                                                          element2.code ==
                                                          element.country)
                                                      .icon),
                                            )
                                          : Icon(
                                              Icons.flag,
                                              color: Colors.white,
                                            ),
                                    ),
                                  )),
                                  Expanded(
                                      child: Text(element.name ?? "--",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge)),
                                  Expanded(
                                      child: Text(element.name2 ?? "--",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge)),
                                  Expanded(
                                      child: Text(element.phone ?? "--",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge)),
                                  Expanded(
                                    child: Container(),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                )
        ],
      ),
    );
  }
}
