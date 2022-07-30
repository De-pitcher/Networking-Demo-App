import 'package:flutter/material.dart';
import 'package:networking_demo/model/album.dart';
import 'package:networking_demo/network.dart';

class CreateAlbum extends StatefulWidget {
  const CreateAlbum({Key? key}) : super(key: key);

  @override
  State<CreateAlbum> createState() => _CreateAlbumState();
}

class _CreateAlbumState extends State<CreateAlbum> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Data Example'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = Network.createAlbum(_controller.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      }),
    );
  }
}
