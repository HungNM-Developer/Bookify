import 'package:bookify/config/color.dart';
import 'package:bookify/live_data.dart';
import 'package:bookify/src/page/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookify/src/page/account/account_cubit.dart';
import 'package:bookify/src/page/account/account_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/widget/category_title.dart';
import '../login/login_screen.dart';
import 'widget/borrow_request/borrow_request_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final screenCubit = AccountCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AccountCubit, AccountState>(
        bloc: screenCubit,
        listener: (BuildContext context, AccountState state) {
          if (state.error != null) {}
        },
        builder: (BuildContext context, AccountState state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return LiveData.accessToken.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_circle_rounded,
                        size: 100,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          await Navigator.of(context).push<bool>(
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(AccountState state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
            top: 60,
            bottom: 20,
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_circle_rounded,
                  size: 70,
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('Hi, ${LiveData.userName} '),
                  titleTextStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  subtitle: Text(LiveData.email),
                ),
              ),
              IconButton(
                onPressed: () async {
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  await Future.delayed(const Duration(milliseconds: 300))
                      .then((value) {
                    _prefs.remove('ACCESS_TOKEN');
                    _prefs.remove('USERNAME');
                    _prefs.remove('ROLE');
                    LiveData.accessToken = '';
                    LiveData.userName = '';
                    LiveData.role = '';
                  }).then((value) async {
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const DashboardScreen(),
                      ),
                    );
                  });
                },
                icon: const Icon(
                  Icons.logout,
                ),
              ),
            ],
          ),
        ),
        if (LiveData.role == 'admin')
          const Expanded(child: BorrowRequestScreen())
        else
          const CategoryTitle('Favorite Books'),
      ],
    );
  }
}
