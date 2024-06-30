// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:herdmannew/model/Notification_Gloable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../Dashboard/Dashboard.dart';

class Notificationpage extends StatefulWidget {
  const Notificationpage({Key? key}) : super(key: key);

  @override
  State<Notificationpage> createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {
  List<Notification_Gloable> notifications = [];
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    setState(() {});
  }

  get() async {
    var box = await Hive.openBox<Notification_Gloable>("Notification_Gloable")
        .asStream();
    box.listen((event) {
      notifications = event.values.toList();
      print("Notification List === " + notifications.length.toString());
      setState(() {
        loading = true;
      });
    });
  }
  DeleteNoti(String id) async {
    var box = await Hive.openBox<Notification_Gloable>("Notification_Gloable");
    await box.delete(id);
    await box.close();
    await get();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return DashBoardScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Notification",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return DashBoardScreen();
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
            child: loading == false?
            const Center(
              child: CircularProgressIndicator(),
            )
            :notifications.isEmpty
                ? const Center(
                    child:Image(
                        height: 150,
                        width: 150,
                        image:
                        AssetImage("assets/images/No-Data-Found.webp")),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(elevation: 2,child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Row(children: [
                            Text("Type : " + notifications[index].Type),
                            const Spacer(),
                            Con_Wid.mIconButton(VisualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity,vertical: VisualDensity.minimumDensity),onPressed: () {
                              DeleteNoti(notifications[index].ID.toString());
                            }, icon: const Icon(Icons.delete,color: Colors.red,))
                          ],),
                          Text("Date : ${DateFormat("dd-MM-yyyy hh:mm:ss a").format(DateTime.parse(notifications[index].Date))}"),
                          Text("ID : "+notifications[index].TagId),
                        ],),
                      ),);
                    },
                    itemCount: notifications.length)),
      ),
    );
  }
}
