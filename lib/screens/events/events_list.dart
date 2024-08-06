import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/models/events_model.dart';
import 'package:maru_naam_che_pathshala_2/screens/events/events_details.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class EventsList extends StatefulWidget {
  const EventsList({
    super.key,
  });

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  bool isLoading = true;
  List<EventsModel> modal = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: "Events".text.make(),
      ),
      body: modal.isNotEmpty
          ? ListView.builder(
              itemCount: modal.length,
              itemBuilder: (context, i) {
                String date = '', time = '';
                final dateTime = modal[i].datetime!.split(" ");
                date = ddMMyyyy(dateTime[0]);
                time = dateTime[1];
                return Card(
                  child: ListTile(
                    title: modal[i].title!.text.bold.make(),
                    subtitle: '$date $time'.text.sm.thin.gray500.make(),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: modal[i].img!,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                )
                    .onTap(() {
                      Get.to(() =>
                          EventsDetailsScreen(id: modal[i].id!.toString()));
                    })
                    .px(8)
                    .py(4);
              })
          : isLoading
              ? progressInd()
              : Center(
                  child: "NO EVENT FOUND".text.bold.make(),
                ),
    );
  }

  getData() async {
    final data = await ApiService.getData(endPoint: EndPoints.events);
    final result = eventsModelFromJson(data);
    modal = result;
    isLoading = false;
    setState(() {});
  }
}
