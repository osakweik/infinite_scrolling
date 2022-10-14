import 'package:flutter/material.dart';
import 'package:infinite_scrolling/models/photos.dart';
import 'package:infinite_scrolling/network/api.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  late Future<List<Photo>> photos;

  @override
  void initState() {
    super.initState();
    photos = Api.getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scroll - Photo'),
      ),
      body: FutureBuilder<List<Photo>>(
        future: photos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Image.network(
                        snapshot.data?[index].thumbnailUrl ?? "",
                      ),
                    ),
                    title: Text(snapshot.data?[index].title ?? "Null"),
                    subtitle: Text(snapshot.data?[index].url ?? ""),
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
        },
      ),
    );
  }
}
