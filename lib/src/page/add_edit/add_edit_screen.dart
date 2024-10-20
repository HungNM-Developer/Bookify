import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookify/src/page/add_edit/add_edit_cubit.dart';
import 'package:bookify/src/page/add_edit/add_edit_state.dart';

import '../../widgets/app_text_form_field.dart';
import '../../widgets/gradient_background.dart';

class AddEditScreen extends StatefulWidget {
  final bool isEdit;
  const AddEditScreen({
    Key? key,
    this.isEdit = false,
  }) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController authorController;
  late final TextEditingController quantityController;

  // The selected value for the dropdown
  List<String> _selectedTopics = [];

  // The list of items in the dropdown
  final List<String> _dropdownTopics = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
    'Item 12',
  ];

  void initializeControllers() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    authorController = TextEditingController();
    quantityController = TextEditingController();
  }

  void disposeControllers() {
    titleController.dispose();
    descriptionController.dispose();
    authorController.dispose();
    quantityController.dispose();
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void _openMultiSelectDialog() async {
    final List<String> selectedValues = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: _dropdownTopics,
          selectedItems: _selectedTopics,
        );
      },
    );

    if (selectedValues.isNotEmpty) {
      setState(() {
        _selectedTopics = selectedValues;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientBackground(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[900], shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.isEdit ? 'Edit book' : 'Add book',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Let's add/edit your book",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppTextFormField(
                    //autofocus: true,
                    labelText: 'Title',
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    //onChanged: (value) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty ? 'Enter your title' : null;
                    },
                  ),
                  AppTextFormField(
                    labelText: 'Description',
                    maxLines: 4,
                    controller: descriptionController,
                    textInputAction: TextInputAction.none,
                    keyboardType: TextInputType.multiline,
                    //onChanged: (_) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty ? 'Enter your description' : null;
                    },
                  ),
                  AppTextFormField(
                    labelText: 'Quantity',
                    controller: quantityController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    //onChanged: (_) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty ? 'Enter quantity' : null;
                    },
                  ),
                  AppTextFormField(
                    labelText: 'Author',
                    controller: authorController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    //onChanged: (_) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty ? 'Enter author' : null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Selected Topics: ${_selectedTopics.join(', ')}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _openMultiSelectDialog,
                    child: const Text('Select topics'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        titleController.clear();
                        descriptionController.clear();
                        quantityController.clear();
                        authorController.clear();
                      },
                      child: Text(widget.isEdit ? 'Save' : 'Add'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;

  const MultiSelectDialog({
    super.key,
    required this.items,
    required this.selectedItems,
  });

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<String> _tempSelectedItems = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedItems = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Items'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: _tempSelectedItems.contains(item),
              title: Text(item),
              onChanged: (bool? selected) {
                setState(() {
                  if (selected == true) {
                    _tempSelectedItems.add(item);
                  } else {
                    _tempSelectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(widget.selectedItems);
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_tempSelectedItems);
          },
        ),
      ],
    );
  }
}
