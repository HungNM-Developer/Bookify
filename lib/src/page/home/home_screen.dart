import 'package:flutter/material.dart';
import 'widget/coming_book.dart';
import 'widget/custom_app_bar.dart';
import 'widget/recommended_book.dart';
import 'widget/trending_book.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const CustomAppBar(),
          ComingBook(),
          RecommendedBook(),
          TrendingBook(),
        ],
      ),
    );
  }
}
