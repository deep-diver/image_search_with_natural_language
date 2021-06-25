import 'dart:convert';
import 'package:http/http.dart' as http;

class RestClient {
  List<String>? parseSemantics(String responseBody) {
    final parsed = jsonDecode(responseBody)['top_urls'];
    List<String>? urls = parsed != null ? List.from(parsed) : null;
    return urls;
  }

  Future<List<String>> fetchSematicPhotos(
      http.Client client, String tag, String semanticQuery, int topK) async {
    tag = Uri.encodeComponent(tag);
    semanticQuery = Uri.encodeComponent(semanticQuery);
    final response = await client.get(Uri.parse(
        'https://mlgde.com/search?t=$tag&s_query=$semanticQuery&k=${topK.toString()}'));

    print('$tag + $semanticQuery');

    List<String>? urls = parseSemantics(response.body);
    if (urls != null) {
      return urls;
    }
    return [];
  }
}
