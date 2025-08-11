import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigator extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNavigator({super.key, required this.currentIndex});

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
      case 3:
        context.go('/home/3');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: widget.currentIndex,
      selectedItemColor: const Color(0xff6200ee),
      unselectedItemColor: const Color(0xff757575),
      onTap: (index) {
        onItemTapped(context, index);
      },

      items: _navBarItems,
    );
  }
}

// ...existing code...

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Inicio"),
    selectedColor: Colors.blue,
  ),
  SalomonBottomBarItem(
    icon: Icon(Icons.whatshot),
    title: const Text("Populares"),
    selectedColor: Colors.red,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.favorite),
    title: const Text("Favoritos"),
    selectedColor: Colors.amber,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Perfil"),
    selectedColor: Colors.purple,
  ),
];
// ...existing code...
