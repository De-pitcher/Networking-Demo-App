import 'package:flutter/material.dart';

import 'package:networking_demo/model/album.dart';
import 'package:networking_demo/network.dart';

class DeleteAlbum extends StatefulWidget {
  Future<Album>? future;
  DeleteAlbum({Key? key, this.future}) : super(key: key);

  @override
  State<DeleteAlbum> createState() => _DeleteAlbumState();
}

class _DeleteAlbumState extends State<DeleteAlbum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Data Example'),
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: widget.future,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data?.title ?? 'Deleted'),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.future =
                              Network.deleteAlbum(snapshot.data!.id.toString());
                        });
                      },
                      child: const Text('Delete Data'),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }
            return const CircularProgressIndicator();
          }),
        ),
      ),
    );
  }
}
