import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { travel, leisure, food, work }

const categoryIcons = {
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.food: Icons.lunch_dining,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    // required this.uuid,
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final Category category;

  String get getDateInFormate {
    return formatter.format(dateTime);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}
