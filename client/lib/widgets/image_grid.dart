import 'package:flutter/material.dart';

class ImageGridWidget extends StatelessWidget {
  final List<String> topUrls;

  const ImageGridWidget({Key? key, required this.topUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
              topUrls.length, (index) => getItemCard(topUrls[index]))),
    );
  }

  Widget getItemCard(String url) {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5), child: Image.network(url));
  }
}
