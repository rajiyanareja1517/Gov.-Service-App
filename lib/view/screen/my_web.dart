import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:government_service/provider/change_provider.dart';
import 'package:provider/provider.dart';

class MyWebPage extends StatefulWidget {
  const MyWebPage({super.key});

  @override
  State<MyWebPage> createState() => _MyWebPageState();
}

class _MyWebPageState extends State<MyWebPage> {
  InAppWebViewController? inAppWebViewController;
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    Provider.of<ChangeProvider>(context, listen: false).onChangeLoad(true);
    pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        if (Platform.isAndroid) {
          inAppWebViewController?.reload();
        } else {
          var webUri = await inAppWebViewController?.getUrl();
          inAppWebViewController?.loadUrl(urlRequest: URLRequest(url: webUri));
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Consumer<ChangeProvider>(
            builder: (BuildContext context, ChangeProvider value, Widget? child) {
              if (value.webProgress == 1) {
                return SizedBox();
              } else {
                return LinearProgressIndicator(
                  minHeight: 10,
                  value: value.webProgress,
                  color: Colors.yellow,
                );
              }
            },
          ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri("https://www.google.com/"),
              ),
              onWebViewCreated: (controller) {
                inAppWebViewController = controller;
              },
              pullToRefreshController: pullToRefreshController,
              onLoadStart: (controller, url) {
                Provider.of<ChangeProvider>(context, listen: false).onChangeLoad(true);
              },
              onProgressChanged: (controller, progress) {
                Provider.of<ChangeProvider>(context, listen: false).onWebProgress(progress / 100);

                print("progress===> $progress");
              },
              onLoadStop: (controller, url) {
                Provider.of<ChangeProvider>(context, listen: false).onChangeLoad(false);
              },
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    inAppWebViewController?.goBack();
                  },
                  icon: Icon(Icons.chevron_left)),
              Expanded(
                child: TextFormField(
                  onChanged: (value) {
                    String search="https://www.google.com/search?q=$value";
                    inAppWebViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(search)));

                  },
                  onFieldSubmitted: (value) {
                    String search="https://www.google.com/search?q=$value";
                    inAppWebViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(search)));

                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    inAppWebViewController?.reload();
                  },
                  icon: Icon(Icons.refresh)),
              IconButton(
                  onPressed: () {
                    inAppWebViewController?.goForward();
                  },
                  icon: Icon(Icons.chevron_right)),
            ],
          )
        ],
      ),
    );
  }
}
