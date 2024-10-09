import 'package:flutter/material.dart';

import '../../settings/settings_controller.dart';
import 'widget/coming_book.dart';
import 'widget/custom_app_bar.dart';
import 'widget/recommended_book.dart';
import 'widget/trending_book.dart';

class HomePage extends StatelessWidget {
  final SettingsController settingsController;
  const HomePage({Key? key, required this.settingsController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomAppBar(settingsController: settingsController),
          ComingBook(),
          RecommendedBook(),
          TrendingBook(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  BottomNavigationBar _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: const Color(0xFF6741FF),
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Book',
          icon: Icon(Icons.menu_book_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Column',
          icon: Icon(Icons.view_week_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Person',
          icon: Icon(Icons.person_outline),
        )
      ],
    );
  }
}
