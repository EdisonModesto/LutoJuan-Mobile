import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyView extends ConsumerStatefulWidget {
  const PrivacyPolicyView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends ConsumerState<PrivacyPolicyView> {
  WebViewController controller = WebViewController();

  @override
  void initState() {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            print("started");
          },
          onPageFinished: (String url) {
            print("finished");
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.freeprivacypolicy.com/live/85ed0e64-e215-45af-84e9-3d12d8fd55eb'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: WebViewWidget(
            controller: controller,
          )
      ),
    );
  }
}
