import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookify/src/page/account/account_cubit.dart';
import 'package:bookify/src/page/account/account_state.dart';

import '../home/widget/trending_book.dart';

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

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(AccountState state) {
    return ListView(
      children: [
        TrendingBook(),
      ],
    );
  }
}
