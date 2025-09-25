// lib/widgets/bottom_navigation_widget.dart
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../core/theme/app_colors.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationWidget({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.primary, 
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.background, 
      items: _buildBottomNavItems(),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavItems() {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined),
        activeIcon: const Icon(Icons.home),
        label: AppConstants.homeLabel,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.add_circle_outline),
        activeIcon: const Icon(Icons.add_circle),
        label: AppConstants.createLabel,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person_outline),
        activeIcon: const Icon(Icons.person),
        label: AppConstants.profileLabel,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.chat_bubble_outline),
        activeIcon: const Icon(Icons.chat_bubble),
        label: AppConstants.chatLabel,
      ),
    ];
  }
}
