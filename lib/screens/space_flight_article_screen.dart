import 'package:flutter/material.dart';
import 'package:infinite_scrolling/models/space_flight_article.dart';
import 'package:infinite_scrolling/network/api.dart';

class SpaceFlightArticleScreen extends StatefulWidget {
  const SpaceFlightArticleScreen({Key? key}) : super(key: key);

  @override
  State<SpaceFlightArticleScreen> createState() =>
      _SpaceFlightArticleScreenState();
}

class _SpaceFlightArticleScreenState extends State<SpaceFlightArticleScreen> {
  late Future<List<SpaceFlightArticle>> articles;

  @override
  void initState() {
    super.initState();
    articles = Api.getSpaceFlightArticles(start: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceFlight Articles'),
      ),
      body: FutureBuilder<List<SpaceFlightArticle>>(
        future: articles,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                // print('ARTICLES COUNT - ${snapshot.data?.length}');
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(snapshot.data?[index].title ?? 'No Title'),
                    subtitle: Text(
                      snapshot.data?[index].summary ?? 'Empty',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text("${index + 1}"),
                  ),
                );
              },
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('An error occured ${snapshot.error.toString()}'),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
