import 'package:flutter/cupertino.dart';
import 'package:networking_demo/model/photo.dart';

class PhotosList extends StatelessWidget {
  final List<Photo> photos;
  const PhotosList({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: ((context, index) {
          return Image.network(photos[index].thumbnailUrl);
        }));
  }
}
