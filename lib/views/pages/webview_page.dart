import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miru_app/data/services/extension_service.dart';
import 'package:miru_app/utils/miru_storage.dart';
import 'package:webview_cookie_manager_plus/webview_cookie_manager_plus.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    super.key,
    required this.extensionRuntime,
    required this.url,
  });
  final ExtensionService extensionRuntime;
  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late String url = widget.extensionRuntime.extension.webSite + widget.url;
  final cookieManager = WebviewCookieManager();
  late Uri loadUrl = Uri.parse(url);

  _setCookie() async {
    if (loadUrl.host != Uri.parse(url).host) {
      return;
    }
    final cookies = await cookieManager.getCookies(loadUrl.toString());
    final cookieString =
        cookies.map((e) => '${e.name}=${e.value}').toList().join(';');
    debugPrint('$url $cookieString');
    widget.extensionRuntime.setCookie(
      cookieString,
    );
  }

  @override
  void dispose() {
    _setCookie();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loadUrl.toString()),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(url),
        ),
        initialSettings: InAppWebViewSettings(
          userAgent: MiruStorage.getUASetting(),
        ),
        onLoadStart: (controller, url) {
          setState(() {
            loadUrl = url!;
          });
        },
      ),
    );
  }
}
