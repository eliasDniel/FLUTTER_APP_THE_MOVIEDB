import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigator extends StatefulWidget {
  const CustomBottomNavigator({super.key});

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xff6200ee),
      unselectedItemColor: const Color(0xff757575),
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
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
    selectedColor: Colors.blueAccent,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.favorite),
    title: const Text("Favoritos"),
    selectedColor: Colors.lightBlue,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Perfil"),
    selectedColor: Colors.indigo,
  ),
];
// ...existing code...