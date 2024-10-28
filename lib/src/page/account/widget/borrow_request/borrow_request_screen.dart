import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookify/src/page/account/widget/borrow_request/borrow_request_cubit.dart';
import 'package:bookify/src/page/account/widget/borrow_request/borrow_request_state.dart';
import 'package:intl/intl.dart';

import '../../../home/widget/category_title.dart';

class BorrowRequestScreen extends StatefulWidget {
  const BorrowRequestScreen({Key? key}) : super(key: key);

  @override
  _BorrowRequestScreenState createState() => _BorrowRequestScreenState();
}

class _BorrowRequestScreenState extends State<BorrowRequestScreen> {
  final screenCubit = BorrowRequestCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BorrowRequestCubit()..loadInitialData(),
      child: Scaffold(
        body: BlocConsumer<BorrowRequestCubit, BorrowRequestState>(
          bloc: screenCubit,
          listener: (BuildContext context, BorrowRequestState state) {
            if (state.error != null) {}
          },
          builder: (BuildContext context, BorrowRequestState state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return buildBody(state);
          },
        ),
      ),
    );
  }

  Widget buildBody(BorrowRequestState state) {
    final listRequest = state.result ?? [];
    return Column(
      children: [
        const CategoryTitle('Borrow Requests'),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            primary: false,
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (listRequest as List).length,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 135, 105, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(listRequest[index]['username'] ?? ''),
                    Text(listRequest[index]['title'] ?? ''),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(
                              DateTime.tryParse(
                                      listRequest[index]['borrowDate'] ?? '') ??
                                  DateTime.now(),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(
                              DateTime.tryParse(
                                      listRequest[index]['returnDate'] ?? '') ??
                                  DateTime.now(),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      listRequest[index]['status'] ?? '',
                      style: const TextStyle(
                        color: Colors.yellowAccent,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
