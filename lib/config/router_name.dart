import 'package:bookify/src/page/dashboard/dashboard_screen.dart';
import 'package:bookify/src/page/register/register_screen.dart';
import 'package:flutter/material.dart';

import '../src/page/account/account_screen.dart';
import '../src/page/add_edit/add_edit_screen.dart';
import '../src/page/home/home_screen.dart';
import '../src/page/login/login_screen.dart';

class RouterName {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'LoginScreen':
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case 'RegisterScreen':
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case 'DashboardScreen':
        return MaterialPageRoute(builder: (context) => const DashboardScreen());
      case 'HomeScreen':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case 'AccountScreen':
        return MaterialPageRoute(builder: (context) => const AccountScreen());
      case 'AddEditScreen':
        return MaterialPageRoute(builder: (context) => const AddEditScreen());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
