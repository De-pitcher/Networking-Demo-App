import 'package:flutter/material.dart';
import 'package:networking_demo/model/album.dart';
import 'package:networking_demo/network.dart';
import 'package:networking_demo/screens/create_album.dart';
import 'package:networking_demo/screens/delete_album.dart';
import 'package:networking_demo/screens/photo_screen.dart';
import 'package:networking_demo/screens/update_screen.dart';
import 'package:networking_demo/screens/websocket_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = Network.fetchAlbum('4');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: DeleteAlbum(future: _futureAlbum)
      // home: const PhotoScreen(title: 'Photo Screen'),
      // home: const CreateAlbum(),
      // home: const UpdateScreen(),
      home: const WebSocketDemo(title: 'WebSocket Demo'),
    );
  }
}
