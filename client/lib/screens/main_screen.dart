import 'package:client/widgets/image_grid.dart';
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
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter Query'),
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
                setState(() {
                  isFetching = true;
                });
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
    if (!isFetching) {
      return CircularProgressIndicator();
    }

    return Expanded(child: ImageGridWidget());
  }
}
