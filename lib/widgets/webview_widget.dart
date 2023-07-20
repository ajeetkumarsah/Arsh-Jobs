import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/constant.dart';
import 'custom_appbar.dart';

// ignore: must_be_immutable
class WebviewWidget extends StatefulWidget {
  String? url, title;
  WebviewWidget({Key? key, this.url, this.title}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _WebviewWidgetState createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget> {
  SharedPreferences? sp;
  int? id;
  String? url, route;
  WebViewController? _webViewController;

  void reloadWebView() {
    _webViewController?.reload();
  }

  @override
  void initState() {
    super.initState();
    setWebview();
  }

  _launchURL(url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  setWebview() {
    _webViewController = WebViewController()
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
            setState(() {});
            if (request.url.contains("https://api.whatsapp.com/")) {
              _launchURL(request.url);
              return NavigationDecision.prevent;
            } else if (request.url.contains("tel:")) {
              _launchURL(request.url);
              return NavigationDecision.prevent;
            } else if (request.url.contains("mailto:")) {
              _launchURL(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url!));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, defaultAppBarHeight),
            child: CustomAppBar(
              title: widget.title,
              centerTitle: true,
            )),
        body: WebViewWidget(
          controller: _webViewController!,
        ),
      ),
    );
  }
}
