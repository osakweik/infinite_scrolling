import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginatedPostsScreen extends StatefulWidget {
  const PaginatedPostsScreen({Key? key}) : super(key: key);

  @override
  State<PaginatedPostsScreen> createState() => _PaginatedPostsScreenState();
}

class _PaginatedPostsScreenState extends State<PaginatedPostsScreen> {
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  int _page = 0;
  final int _limit = 20;
  bool _hasNextPage = true;

  late ScrollController _controller;
  List _posts = [];
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final response =
          await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
      setState(() {
        _posts = jsonDecode(response.body);
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      try {
        final response =
            await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
        final List fetchedPosts = json.decode(response.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong');
        }
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JsonPlaceholder paginated posts'),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _posts.length,
                    itemBuilder: (_, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: ListTile(
                          title: Text(_posts[index]['title']),
                          subtitle: Text(_posts[index]['body']),
                          trailing: Text('${index + 1}'),
                        ),
                      );
                    },
                  ),
                ),
                // when the _loadMore function is running
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                // When nothing else to load
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
            ),
    );
  }
}
