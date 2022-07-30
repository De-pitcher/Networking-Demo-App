import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:networking_demo/model/album.dart';
import 'package:networking_demo/model/photo.dart';

class Network {
  static Uri url(String url) => Uri.parse(url);
  static Map<String, String> customHeader = headers(
    'Content-Type',
    'application/json; charset=UTF-8',
  );
  static Map<String, String> headers(String key, String value) => {
        key: value,
      };

  Future<Album> fetchAlbumWithAuthHeader() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      // Send authorization headers to the backend.
      headers:
          headers(HttpHeaders.authorizationHeader, 'Basic your_api_token_here'),
    );
    final responseJson = jsonDecode(response.body);

    return Album.fromJson(responseJson);
  }

  static Future<Album> fetchAlbum(String id) async {
    final response = await http.get(
      url('https://jsonplaceholder.typicode.com/albums/$id'),
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<Album> createAlbum(String title) async {
    final response = await http.post(
      url('https://jsonplaceholder.typicode.com/albums'),
      headers: customHeader,
      body: jsonEncode(<String, String>{'title': title}),
    );

    if (response.statusCode == 201) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

  static Future<Album> updateAlbum(String title) async {
    final response = await http.put(
      url('https://jsonplaceholder.typicode.com/albums/1'),
      headers: customHeader,
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update album.');
    }
  }

  static Future<Album> deleteAlbum(String id) async {
    final http.Response response = await http
        .delete(url('https://jsonplaceholder.typicode.com/albums/$id'));

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete album');
    }
  }

  static Future<http.Response> fetchPhoto(http.Client client) async =>
      client.get(url('https://jsonplaceholder.typicode.com/photos'));

  static Future<List<Photo>> fetchPhotos(http.Client client) async {
    final resposne = await fetchPhoto(client);

    return compute(parsedPhotos, resposne.body);
  }
}
