import 'package:expense_tracker/widgets/expense/model/expense_model.dart';

List<Expense> registeredExpenses = [
  Expense(
      title: "Default HardCoded Expenses",
      amount: 12,
      dateTime: DateTime.now(),
      category: Category.leisure),
  Expense(
      title: "You can add NewExpense by clicking on Add Icon",
      amount: 22,
      dateTime: DateTime.now(),
      category: Category.travel),
];
