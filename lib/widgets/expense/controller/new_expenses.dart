import 'package:expense_tracker/widgets/expense/data/expense_data.dart';
import 'package:flutter/material.dart';
import '../model/expense_model.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.addNewExpense});

  final void Function() addNewExpense;
  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  List<String> categoryStrings =
      Category.values.map((e) => e.toString().split('.').last).toList();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text(
                  "Title",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text(
                      "Amount",
                    ),
                  ),
                )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(_selectedDate == null
                          ? "No Selected Date"
                          : formatter.format(_selectedDate!)),
                      IconButton(
                          onPressed: presentDayPicker,
                          icon: const Icon(Icons.calendar_month)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    }),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    saveExpense();
                  },
                  child: const Text("Save Expense"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void presentDayPicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void saveExpense() {
    final amount = double.tryParse(_amountController.text);
    final invalidAmount = amount == null || amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please make sure a valid title, amount, category and date is entered."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Okay"),
            )
          ],
        ),
      );
      return;
    }
    registeredExpenses.add(Expense(
        title: _titleController.text,
        amount: amount,
        dateTime: _selectedDate!,
        category: _selectedCategory));
    widget.addNewExpense();

  
    Navigator.pop(context);
  }
}
