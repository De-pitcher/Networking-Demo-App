import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:networking_demo/model/photo.dart';
import 'package:networking_demo/network.dart';
import 'package:networking_demo/widget/photos_list.dart';

class PhotoScreen extends StatelessWidget {
  final String title;
  const PhotoScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: Network.fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
