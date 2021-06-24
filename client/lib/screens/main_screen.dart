import 'package:client/rest_client.dart';
import 'package:client/widgets/image_grid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

const appName = 'Image Search with Natural Language';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  static const String routeName = "main_screen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isFetching = false;
  RestClient client = RestClient();
  List<String> topUrls = [];
  final tagController = TextEditingController();
  final queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: tagController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter keywords to search Pixabay'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: queryController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Semantic Search Query'),
              // maxLines: 3,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Text(
                'Send Query',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                if (tagController.text != "" || queryController.text != "") {
                  setState(() {
                    isFetching = true;
                  });
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            getImageGridWidget(),
          ],
        ),
      ),
    );
  }

  Widget getImageGridWidget() {
    if (isFetching) {
      return FutureBuilder<List<String>>(
        future: client.fetchSematicPhotos(
            http.Client(), tagController.text, queryController.text, 10),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          topUrls = snapshot.data!;
          isFetching = false;

          return ImageGridWidget(topUrls: topUrls);
        },
      );
    } else {
      return Container();
    }
  }

  Widget getItemCard(String url) {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5), child: Image.network(url));
  }
}
