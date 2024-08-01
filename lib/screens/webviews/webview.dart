import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key, required this.url});
  final String url;
  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  InAppWebViewController? webViewController;
  String url = '';
  @override
  void initState() {
    super.initState();
    url = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    currUrl();
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          goback();
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    goback();
                  },
                  icon: const Icon(Icons.arrow_back)),
              IconButton(
                  onPressed: () async {
                    if (webViewController == null) return;
                    if (await webViewController!.canGoForward()) {
                      await webViewController!.goForward();
                    }
                  },
                  icon: const Icon(Icons.arrow_forward))
            ],
            automaticallyImplyLeading: false,
            leadingWidth: 50,
            leading: const CloseButton(
              color: Colors.white,
            ),
            title:
                url.text.overflow(TextOverflow.ellipsis).maxLines(1).sm.make(),
            backgroundColor: Colors.grey,
          ),
          body: InAppWebView(
            onWebViewCreated: (controller) {
              webViewController = controller;
              setState(() {});
            },
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
          ),
        ),
      ),
    );
  }

  void goback() async {
    if (webViewController == null) return;
    if (await webViewController!.canGoBack()) {
      await webViewController!.goBack();
    } else {
      Get.back();
    }
  }

  void currUrl() async {
    if (webViewController == null) return;
    WebUri? curl = await webViewController!.getUrl();
    url = curl.toString();
    setState(() {});
  }
}
