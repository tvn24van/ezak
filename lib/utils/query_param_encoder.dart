/// we need to use method from [url_launcher doc](https://pub.dev/packages/url_launcher#encoding-urls)
/// to enforce proper encoding
String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}