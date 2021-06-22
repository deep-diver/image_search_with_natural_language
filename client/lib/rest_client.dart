import 'package:http/http.dart' as http;

class RestClient {
  Future<void> send() async {
    var url = Uri.parse('https://example.com/whatsit/create');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // print(await http.read('https://example.com/foobar.txt'));
  }
}
