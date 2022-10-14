import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:infinite_scrolling/models/photos.dart';
import 'package:infinite_scrolling/models/posts.dart';
import 'package:infinite_scrolling/models/space_flight_article.dart';

class Api {
  static http.Client client = http.Client();

  static Future<List<Post>> getPosts() async {
    const String postUrl = "https://jsonplaceholder.typicode.com/posts";

    try {
      final response = await client.get(Uri.parse(postUrl));
      if (response.statusCode == 200) {
        //return Post.fromJson(jsonDecode(response.body));
        return List.from(
          jsonDecode(response.body).map((value) => Post.fromJson(value)),
        );
      } else {
        throw "${response.body}: Error - failed to get posts.";
      }
    } on SocketException {
      throw "It seems your internet is not available";
    } catch (e) {
      throw e.toString();
    }
  }

  /*static Future<List<Post>> getPaginatedPosts() async {
    const String postUrl =
        "https://jsonplaceholder.typicode.com/posts?_page=1&_limit=20";

    try {
      final response = await client.get(Uri.parse(postUrl));
      if (response.statusCode == 200) {
        //return Post.fromJson(jsonDecode(response.body));
        return List.from(
          jsonDecode(response.body).map((value) => Post.fromJson(value)),
        );
      } else {
        throw "${response.body}: Error - failed to get posts.";
      }
    } on SocketException {
      throw "It seems your internet is not available";
    } catch (e) {
      throw e.toString();
    }
  }*/

  static Future<List<Photo>> getPhotos() async {
    const String photoUrl = "https://jsonplaceholder.typicode.com/photos";
    try {
      final response = await client.get(Uri.parse(photoUrl));
      if (response.statusCode == 200) {
        return List.from(
          jsonDecode(response.body).map((value) => Photo.fromJson(value)),
        );
      } else {
        throw "${response.body}: Error - failed to get photos.";
      }
    } on SocketException {
      throw "It seems your internet is not available";
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<SpaceFlightArticle>> getSpaceFlightArticles({
    required int start,
  }) async {
    String url =
        "https://api.spaceflightnewsapi.net/v3/articles?_limit=200&_start=$start";
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return List.from(jsonDecode(response.body)
            .map((value) => SpaceFlightArticle.fromJson(value)));
      } else {
        throw "${response.body}: Error - failed to get articles";
      }
    } on SocketException {
      throw "It seems your internet is not available";
    } catch (e) {
      throw e.toString();
    }
  }
}
