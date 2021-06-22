import 'package:flutter/material.dart';

class ImageGridWidget extends StatelessWidget {
  const ImageGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> urls = [
      'https://www.michaelbuble.com/sites/g/files/g2000002856/f/Sample-image10-highres.jpg',
      'https://www.michaelbuble.com/sites/g/files/g2000002856/f/Sample-image10-highres.jpg',
      'https://www.michaelbuble.com/sites/g/files/g2000002856/f/Sample-image10-highres.jpg',
      'https://www.michaelbuble.com/sites/g/files/g2000002856/f/Sample-image10-highres.jpg',
      'https://www.michaelbuble.com/sites/g/files/g2000002856/f/Sample-image10-highres.jpg',
      'https://www.michaelbuble.com/sites/g/files/g2000002856/f/Sample-image10-highres.jpg',
      'https://www.michaelbuble.com/sites/g/files/g2000002856/f/Sample-image10-highres.jpg',
      'https://www.michaelbuble.com/sites/g/files/g2000002856/f/Sample-image10-highres.jpg'
    ];

    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Container(
              height: 150,
              child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                      urls.length, (index) => getItemCard(urls[index])))),
        )
      ]),
    );
  }

  Widget getItemCard(String url) {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5), child: Image.network(url));
  }
}
