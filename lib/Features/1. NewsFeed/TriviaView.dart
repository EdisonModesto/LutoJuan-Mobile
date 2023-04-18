import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Constants/articles.dart';
import '../../Constants/trivias.dart';

class TriviaView extends ConsumerStatefulWidget {
  const TriviaView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TriviaViewState();
}

class _TriviaViewState extends ConsumerState<TriviaView> {
  WebViewController controller = WebViewController();


  @override
  void initState() {
    DateTime now = DateTime.now();
    // Generate a seed for the Random class using the current date
    int seed = now.year + now.month + now.day;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(triviaList[Random(seed).nextInt(triviaList.length-1)].link));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: WebViewWidget(
            controller: controller,
          ),
        )
    );
  }
}
