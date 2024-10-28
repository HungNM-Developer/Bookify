import 'package:bookify/src/page/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/cubit_status.dart';
import '../../live_data.dart';

import '../page/detail/detail_cubit.dart';
import 'app_text_form_field.dart';
import 'package:intl/intl.dart';

class BorrowDialog extends StatefulWidget {
  const BorrowDialog({super.key});

  @override
  State<BorrowDialog> createState() => _BorrowDialogState();
}

class _BorrowDialogState extends State<BorrowDialog> {
  TextEditingController titleController = TextEditingController();
  DateTime? _selectedDateBorrow;
  DateTime? _selectedDateReturn;
  bool showErrorText = false;
  Future<void> _onSelectedDateBorrow(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateBorrow ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDateBorrow) {
      setState(() {
        _selectedDateBorrow = pickedDate;
      });
    }
  }

  Future<void> _onSelectedDateReturn(BuildContext context) async {
    final returnDateCheck = _selectedDateBorrow?.add(const Duration(days: 1));
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: returnDateCheck ?? DateTime.now(),
      firstDate: _selectedDateBorrow ?? DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDateReturn) {
      setState(() {
        _selectedDateReturn = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocListener<DetailCubit, DetailState>(
        listener: (context, state) async {
          if (state.status == CubitStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: const Color.fromARGB(255, 86, 224, 91),
              content: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ));
          }
          if (state.status == CubitStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ));
            if (state.statusCode == 403) {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              await Future.delayed(const Duration(milliseconds: 300))
                  .then((value) {
                _prefs.remove('ACCESS_TOKEN');
                _prefs.remove('USERNAME');
                _prefs.remove('ROLE');
                LiveData.accessToken = '';
                LiveData.userName = '';
                LiveData.role = '';
              }).then((value) async {
                Navigator.of(context).pop();
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const AccountScreen(),
                  ),
                );
              });
            }
          }
        },
        child: SizedBox(
          height: 320,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Borrow Information'),
                const SizedBox(height: 20),
                AppTextFormField(
                  labelText: 'Title',
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.none,
                  validator: (value) {
                    return value!.isEmpty ? 'Enter your title' : null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              await _onSelectedDateBorrow(context);
                            },
                            child: Text(
                              _selectedDateBorrow == null
                                  ? "Borrow date"
                                  : DateFormat('dd/MM/yyyy').format(
                                      _selectedDateBorrow ?? DateTime.now(),
                                    ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (_selectedDateBorrow == null) {
                                setState(() {
                                  showErrorText = true;
                                });
                                return;
                              }
                              await _onSelectedDateReturn(context);
                            },
                            child: Text(
                              _selectedDateReturn == null
                                  ? "Return date"
                                  : DateFormat('dd/MM/yyyy').format(
                                      _selectedDateReturn ?? DateTime.now(),
                                    ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          showErrorText && _selectedDateBorrow == null
                              ? const Text(
                                  "Borrow date is empty",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.red,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Borrow'),
                  onPressed: () async {
                    await context
                        .read<DetailCubit>()
                        .borrowBook(
                          titleController.text,
                          DateFormat('MM/dd/yyyy').format(
                            _selectedDateBorrow ?? DateTime.now(),
                          ),
                          DateFormat('MM/dd/yyyy').format(
                            _selectedDateReturn ?? DateTime.now(),
                          ),
                        )
                        .then(
                          (value) => Navigator.of(context).pop(),
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
