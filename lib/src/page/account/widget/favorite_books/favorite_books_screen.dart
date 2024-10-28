import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookify/src/page/account/widget/favorite_books/favorite_books_cubit.dart';
import 'package:bookify/src/page/account/widget/favorite_books/favorite_books_state.dart';

class FavoriteBooksScreen extends StatefulWidget {
  const FavoriteBooksScreen({Key? key}) : super(key: key);

  @override
  _FavoriteBooksScreenState createState() => _FavoriteBooksScreenState();
}

class _FavoriteBooksScreenState extends State<FavoriteBooksScreen> {
  final screenCubit = FavoriteBooksCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FavoriteBooksCubit, FavoriteBooksState>(
        bloc: screenCubit,
        listener: (BuildContext context, FavoriteBooksState state) {
          if (state.error != null) {}
        },
        builder: (BuildContext context, FavoriteBooksState state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(FavoriteBooksState state) {
    return ListView(
      children: const [],
    );
  }
}
