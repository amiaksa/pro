import 'package:flutter/material.dart';
import 'package:pro/firestore_service.dart';

import 'chart/bar_chart_sample3.dart';
import 'chart/line_chart_sample2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int campaignsCount = 0;
  int pilgrimssCount = 0;
  int userssCount = 0;
  // List<CampaignModel> campaigns = [];

  @override
  void initState() {
    super.initState();
    getCounts();
    // getCampaigns();
  }

  // getCampaigns() async {
  //   FireStoreService fireStoreService = FireStoreService();
  //   campaigns = await fireStoreService.getAllCampaign(true);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "إحصائية السنة الحالية",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
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
                          Text(campaignsCount.toString(),
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
                          Text(pilgrimssCount.toString(),
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
                          Text(campaignsCount.toString(),
                              style: Theme.of(context).textTheme.titleLarge)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "عدد الحملات المستفيدة",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 300, child: BarChartSample3([])),
            Text(
              "عدد الحجاج في الحملة",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 300, child: LineChartSample2())
          ],
        ),
      ),
    );
  }

  Future<void> getCounts() async {
    campaignsCount = await FireStoreService().getCampaignCounts();
    pilgrimssCount = await FireStoreService().getPilgrimsCounts();
    userssCount = campaignsCount;
    setState(() {});
  }
}
