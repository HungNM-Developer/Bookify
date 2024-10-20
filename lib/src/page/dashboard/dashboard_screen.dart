import 'package:bookify/live_data.dart';
import 'package:bookify/src/page/account/account_cubit.dart';
import 'package:bookify/src/page/account/account_screen.dart';
import 'package:bookify/src/page/home/home_screen.dart';
import 'package:bookify/src/page/login/login_cubit.dart';
import 'package:bookify/src/page/login/login_screen.dart';
import 'package:bookify/src/page/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings/settings_controller.dart';
import '../add_edit/add_edit_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  late final SettingsController settingsController;
  List<Widget> widgetOptions = [];
  @override
  void initState() {
    widgetOptions = <Widget>[
      const HomeScreen(),
      const AccountScreen(),
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    LiveData.accessToken = prefs.getString('ACCESS_TOKEN') ?? '';
    super.didChangeDependencies();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AccountCubit(),
        ),
        BlocProvider(
          create: (_) => LoginCubit(),
        ),
        BlocProvider(
          create: (_) => RegisterCubit(),
        ),
      ],
      child: Scaffold(
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: _buildBottomNavigation(),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.grey[100],
          ),
          backgroundColor: const Color(0xFF6741FF),
          onPressed: () {
            if (LiveData.accessToken.isEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddEditScreen(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: const Color(0xFF6741FF),
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Person',
          icon: Icon(Icons.person),
        )
      ],
    );
  }
}
