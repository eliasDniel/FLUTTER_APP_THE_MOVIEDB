import 'package:flutter/material.dart';
import '../widgets/shared/custom_bottom_navigator.dart';
import 'views/home_view.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeView(),
      bottomNavigationBar: const CustomBottomNavigator(),
    );
  }
}
