import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense/controller/new_expenses.dart';
import 'package:expense_tracker/widgets/expense/data/expense_data.dart';
import 'package:expense_tracker/widgets/expense/controller/expneseList/expense_list.dart';
import 'package:expense_tracker/widgets/expense/model/expense_model.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    Widget areExpenses = ExpenseList(
        expenses: registeredExpenses,
        removeExpense: _removeExpense,
      );
    

    if (registeredExpenses.isEmpty) {
      areExpenses = const Center(
        child: Text("No Expense found, Add some expenses"),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _onAddPressedOverlay,
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: registeredExpenses),
          Expanded(child: areExpenses,),
        ],
      ),
    );
  }

  void _onAddPressedOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => NewExpenses(
              addNewExpense: _addNewExpense,
            ));
  }

  void _addNewExpense() {
    setState(() {
      registeredExpenses;
    });
  }

  void _removeExpense(Expense expenseToDelete) {
    final expenseIndex = registeredExpenses.indexOf(expenseToDelete);
    setState(() {
      registeredExpenses.remove(expenseToDelete);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () {
                registeredExpenses.insert(expenseIndex, expenseToDelete);
              },
            );
          },
        ),
      ),
    );
  }
}
