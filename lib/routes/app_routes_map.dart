import 'package:flutter/material.dart';
import 'package:infinite_scrolling/routes/app_routes.dart';
import 'package:infinite_scrolling/screens/paginated_posts_screen.dart';
import 'package:infinite_scrolling/screens/photos_screen.dart';
import 'package:infinite_scrolling/screens/posts_screen.dart';
import 'package:infinite_scrolling/screens/space_flight_article_screen.dart';

Map<String, Widget Function(BuildContext)> appRoutesMap = {
  AppRoutes.postsScreen: (context) => const PostsScreen(),
  AppRoutes.paginatedPostsScreen: (context) => const PaginatedPostsScreen(),
  AppRoutes.photosScreen: (context) => const PhotosScreen(),
  AppRoutes.spaceFlightArticleScreen: (context) =>
      const SpaceFlightArticleScreen(),
};
