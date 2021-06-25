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
              topUrls.length, (index) => getItemCard(context, topUrls[index]))),
    );
  }

  Widget getItemCard(BuildContext context, String url) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          showDialog(
              context: context,
              builder: (_) => SimpleDialog(
                    children: [Image.network(url)],
                  ));
        },
        child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Image.network(url)));
  }
}
