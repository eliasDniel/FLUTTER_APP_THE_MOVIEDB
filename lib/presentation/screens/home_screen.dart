import 'package:app_flutter_the_movie/presentation/screens/views/views.dart';
import 'package:flutter/material.dart';
import '../widgets/shared/custom_bottom_navigator.dart';

class HomeScreen extends StatelessWidget {
  final int pageIndex;
  static const String name = 'home';
  const HomeScreen({super.key, required this.pageIndex});

  final viewsPages = const <Widget>[
    HomeView(),
    FavoritesView(),
    CategoriesView(),
    CategoriesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: pageIndex, children: viewsPages),
      bottomNavigationBar: CustomBottomNavigator(currentIndex: pageIndex),
    );
  }
}
