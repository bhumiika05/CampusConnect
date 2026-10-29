import 'package:serverpod/serverpod.dart';

class AppRedirectRoute extends WidgetRoute {
  final String targetUrl;

  AppRedirectRoute({this.targetUrl = '/'});

  @override
  Future<WebWidget?> build(Session session, Request request) async {
    return RedirectWidget(url: targetUrl);
  }
}
