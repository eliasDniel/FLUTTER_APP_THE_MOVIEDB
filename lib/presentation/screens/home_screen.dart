import 'package:app_flutter_the_movie/presentation/screens/views/profile_view.dart';
import 'package:app_flutter_the_movie/presentation/screens/views/views.dart';
import 'package:flutter/material.dart';
import '../widgets/shared/custom_bottom_navigator.dart';

class HomeScreen extends StatefulWidget {
  final int pageIndex;
  static const String name = 'home';
  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final viewsPages = const <Widget>[
    HomeView(),
    CategoriesView(),
    FavoritesView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: viewsPages,
      ),
      bottomNavigationBar: CustomBottomNavigator(
        currentIndex: widget.pageIndex,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
