import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:maru_naam_che_pathshala_2/models/events_model.dart';
import 'package:maru_naam_che_pathshala_2/screens/zoomable_image/zoomable_image.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class EventsDetailsScreen extends StatefulWidget {
  const EventsDetailsScreen({super.key, required this.id});
  final String id;
  @override
  State<EventsDetailsScreen> createState() => _EventsDetailsScreenState();
}

class _EventsDetailsScreenState extends State<EventsDetailsScreen> {
  late EventsModel events;
  bool load = false;
  double imageHeight = 250; // Initial image height
  double arc = 20;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      if (_scrollController.offset >= 50) {
        imageHeight = 150; // Smaller image height when scrolled up
        arc = 0;
      } else {
        imageHeight = 250; // Original image height when scrolled down
        arc = 20;
      }
    });
  }

  share() async {
    if (events.img != '') {
      http.Response response = await http.get(Uri.parse(events.img!));
      final bytes = response.bodyBytes.buffer.asUint8List();
      final dir = await getApplicationDocumentsDirectory();
      final image = File('${dir.path}/events${events.id!}.png');
      image.writeAsBytesSync(bytes);
      XFile file = XFile(image.path);
      Share.shareXFiles([file], text: events.description!).then((value) {
        image.delete();
      });
      return;
    }
    Share.share(events.description!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: share, icon: const Icon(Icons.share))
          ],
        ),
        body: load
            ? SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    if (events.img! != '')
                      AnimatedContainer(
                        duration: Durations.medium1,
                        width: Get.width,
                        height: imageHeight,
                        child: VxArc(
                            height: arc,
                            child: CachedNetworkImage(
                              imageUrl: events.img!,
                              fit: BoxFit.fill,
                              width: Get.width,
                            )),
                      ).onTap(() {
                        Get.to(() => ZoomableImage(img: events.img!));
                      }),
                    20.vs(),
                    Linkify(
                      onOpen: (link) async {
                        if (await canLaunchUrl(Uri.parse(link.url))) {
                          await launchUrl(Uri.parse(link.url),
                              mode: LaunchMode.externalApplication);
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                      textScaleFactor: 1.2,
                      text: events.description!,
                    ).p(8),
                  ],
                ),
              )
            : progressInd());
  }

  getData() async {
    String q = '&eventid=${widget.id}';
    final data =
        await ApiService.getData(endPoint: EndPoints.eventsDetails, query: q);
    final result = eventModelFromJson(data);
    events = result;
    load = true;
    setState(() {});
  }
}
