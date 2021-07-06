import 'package:client/rest_client.dart';
import 'package:client/widgets/image_grid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

const appName = 'Semantic Image Search';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  static const String routeName = "main_screen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isInitialPhase = true;
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
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => SimpleDialog(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        'Image Search by Natural Language Query',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              Expanded(
                                  child: Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Text(
                                        "This project shows how to build an image search utility using natural language queries. Our aim is to use different and related serverless GCP services to demonstrate this. At the core of our project is OpenAI's CLIP model. It makes use of two encoders - one for images and one for texts. Each encoder is trained to learn representations such that similar images and text embeddings are projected as close as possible.",
                                        textAlign: TextAlign.start,
                                      ))),
                            ]),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Linkify(
                                  onOpen: (link) async {
                                    if (await canLaunch(link.url)) {
                                      await launch(link.url);
                                    } else {
                                      throw 'Could not launch $link';
                                    }
                                  },
                                  text: "Project Repo: https://git.io/JnxLk",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                  linkStyle: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    radius: 30.0,
                                    child: CircleAvatar(
                                      radius: 28.0,
                                      backgroundImage:
                                          AssetImage('images/chansung.png'),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),                                
                                CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    radius: 30.0,
                                    child: CircleAvatar(
                                      radius: 28.0,
                                      backgroundImage:
                                          AssetImage('images/paul.png'),
                                    )),
                                Expanded(
                                    child: Column(children: [
                                  Text(
                                    'Built by ML GDEs',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Chansung Park',
                                      style: TextStyle(fontSize: 12)),                                      
                                  Text('Paul Sayak',
                                      style: TextStyle(fontSize: 12)),
                                ]))
                              ],
                            ),
                          ],
                        ));
              },
              icon: Icon(Icons.info))
        ],
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
                onPressed: isFetching
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          isInitialPhase = false;
                          topUrls = [];
                          isFetching = true;
                        });

                        if (tagController.text != "" ||
                            queryController.text != "") {
                          final urls = await client.fetchSematicPhotos(
                              http.Client(),
                              tagController.text,
                              queryController.text,
                              10);
                          setState(() {
                            topUrls = urls;
                            isFetching = false;
                          });
                        }
                      }),
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
    return new FutureBuilder<String>(builder: (context, snapshot) {
      if (isInitialPhase) {
        return Container();
      }

      if (topUrls.isNotEmpty) {
        return ImageGridWidget(topUrls: topUrls);
      }

      return const Center(child: CircularProgressIndicator());
    });
  }

  Widget getItemCard(String url) {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5), child: Image.network(url));
  }
}
