import 'package:flutter/material.dart';
import 'package:infinite_scrolling/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scrolls'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('JsonPlaceholder posts'),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.postsScreen);
            },
          ),
          ListTile(
            title: const Text('Scroll - JsonPlaceholder posts'),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.photosScreen);
            },
          ),
          ListTile(
            title: const Text('Scroll - JsonPlaceholder paginated posts'),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.paginatedPostsScreen);
            },
          ),
          ListTile(
            title: const Text('Scroll - SpaceFlightNews articles'),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.spaceFlightArticleScreen);
            },
          ),
        ],
      ),
    );
  }
}
