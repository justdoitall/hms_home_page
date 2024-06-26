import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.navigationShell});

  /// Контейнер для навигационного бара.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      leading: const Icon(Icons.person),
      title: const Text("HMS"),
     ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.red,
        /// Лист элементов для нижнего навигационного бара.
        items: _buildBottomNavBarItems,
        /// Текущий индекс нижнего навигационного бара.
        currentIndex: navigationShell.currentIndex,
        /// Обработчик нажатия на элемент нижнего навигационного бара.
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }

  // Возвращает лист элементов для нижнего навигационного бара.
  List<BottomNavigationBarItem> get _buildBottomNavBarItems => [
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'List',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.wallet),
          label: 'activity',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.food_bank),
          label: 'food',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.portrait),
          label: 'info',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.carpenter),
          label: 'center',
        ),

      ];
}