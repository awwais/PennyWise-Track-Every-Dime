import 'package:expense_tracker/widgets/expense/controller/expneseList/expense_item.dart';
import 'package:expense_tracker/widgets/expense/model/expense_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExpenseList extends StatelessWidget {
  ExpenseList({super.key, required this.expenses, required this.removeExpense});

  final List<Expense> expenses;
  void Function(Expense index) removeExpense;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: ((context, index) => Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error,
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              ),
              key: ValueKey(expenses[index]),
              onDismissed: (direction) {
                removeExpense(expenses[index]);
              },
              child: ExpenseItem(
                item: expenses[index],
              ),
            )),
      ),
    );
  }
}
