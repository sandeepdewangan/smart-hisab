import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_hisab/commons/action-bar-icon-button.dart';
import 'package:smart_hisab/commons/text_field.dart';
import 'package:smart_hisab/features/transactions/controller/transaction_controller.dart';
import 'package:smart_hisab/features/transactions/widgets/categories_grid.dart';
import 'package:smart_hisab/models/category.dart';
import 'package:smart_hisab/models/transaction.dart';
import 'package:smart_hisab/providers/providers.dart';

class AddTransactionsView extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddTransactionsView());
  const AddTransactionsView({super.key});

  @override
  ConsumerState<AddTransactionsView> createState() =>
      _AddTransactionsViewState();
}

class _AddTransactionsViewState extends ConsumerState<AddTransactionsView> {
  final amountController = TextEditingController();
  final notesController = TextEditingController();
  TrackerType trackerType = TrackerType.expense;
  DateTime? selectedDate;
  Category? selectedCategory;
  List<String?> errorMessages = [];

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.invalidate(iconProviderTemp);
    ref.invalidate(categoryIconProviderTemp);

    selectedDate = ref.watch(dateProviderTemp);
  }

  onSave() async {
    // clear the errors
    errorMessages.clear();

    // Manage State form here
    final iconCategory = ref.watch(categoryIconProviderTemp);

    if (selectedDate == null) {
      errorMessages.insert(0, 'Select date');
      setState(() {});
      return;
    }
    if (amountController.text.isEmpty) {
      errorMessages.insert(0, "Insert amount");
      setState(() {});
      return;
    }
    if (num.tryParse(amountController.text) == null) {
      errorMessages.insert(0, "Only numbers are allowed");
      setState(() {});
      return;
    }

    if (iconCategory == null) {
      errorMessages.insert(0, 'Select category');
      setState(() {});
      return;
    }

    final double amount = double.parse(amountController.text);
    final String notes = notesController.text.trim();

    Transaction tx = Transaction(
      categoryId: iconCategory.id!,
      amount: amount,
      date: selectedDate!,
      note: notes.isNotEmpty ? notes : null,
    );

    // Sembast Database
    final txController = ref.watch(transactionControllerProvider);
    await txController.addTransaction(tx);

    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectedCategory = ref.watch(categoryIconProviderTemp);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.navigate_before, size: 35),
                  ),
                  Text("Add Transaction", style: TextStyle(fontSize: 20)),
                  ActionBarIconButton(onPressed: onSave, icon: Icons.save),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Expense and Income Toggler
            SegmentedButton(
              segments: [
                ButtonSegment(
                  value: TrackerType.expense,
                  label: Text("Expense"),
                  icon: Icon(Icons.payment),
                ),
                ButtonSegment(
                  value: TrackerType.income,
                  label: Text("Income"),
                  icon: Icon(Icons.attach_money),
                ),
              ],
              selected: {trackerType},
              onSelectionChanged: (newSelection) {
                setState(() {
                  ref.invalidate(categoryIconProviderTemp);
                  trackerType = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 15),
            // ---------- FORM ------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // ---------- DATE ----------
                  Row(
                    children: [
                      TextButton(
                        onPressed: _selectDate,
                        child: const Text(
                          'Select Date: ',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(
                        selectedDate != null
                            ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                            : 'No date selected',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // ---------- Amount ----------
                  AppTextField(
                    controller: amountController,
                    hintText: 'Enter amount',
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                  ),

                  const SizedBox(height: 20),

                  // Note field
                  AppTextField(
                    controller: notesController,
                    hintText: 'Enter short note',
                  ),

                  const SizedBox(height: 10),

                  // ---------- Category ----------
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder:
                                (context) =>
                                    CategoriesGrid(trackerType: trackerType),
                          );
                        },
                        child: const Text(
                          'Select Category:',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(
                        selectedCategory != null
                            ? '${selectedCategory?.name}'
                            : 'No category selected',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  // Error messages
                  const SizedBox(height: 20),
                  Column(children: displayError(errorMessages)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

displayError(List<String?> errorMessages) {
  if (errorMessages.isNotEmpty) {
    return errorMessages
        .map(
          (er) => Text(
            er!,
            style: TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
        )
        .toList();
  } else {
    return [SizedBox(), SizedBox()];
  }
}
