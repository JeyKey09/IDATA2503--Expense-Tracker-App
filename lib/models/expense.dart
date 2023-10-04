import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

/// A date formatter for formatting dates
final formatter = DateFormat.yMd();

/// A uuid generator
const uuid = Uuid();

/// Different categories for the expenses
enum Category {
  food(icon: Icons.lunch_dining),
  travel(icon: Icons.flight_takeoff),
  leisure(icon: Icons.movie),
  work(icon: Icons.work);

  const Category({
    required this.icon,
  });

  final IconData icon;
}

/// A expense class that represents a single expense
class Expense {
  /// The constructor for the expense class
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); // Creates a unique id for the expense

  /// Id of the expense
  final String id;

  /// Title of the expense
  String title;

  /// Amount of the expense
  late double amount;

  /// Date of the expense
  DateTime date;

  /// Category of the expense
  Category category;

  /// A getter that returns a formatted date
  String get formattedDate {
    return formatter.format(date);
  }
}

/// A class that represents a bucket of expenses for a category
class ExpenseBucket {
  /// The constructor for the expense bucket class
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  /// Factory constructor for creating a bucket out of a list of expenses and a category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  /// The category of the bucket
  final Category category;

  /// The list of expenses in the bucket
  final List<Expense> expenses;

  /// Getter for the total amount of expenses in the bucket
  double get totalExpenses {
    double sum = 0;

    // Sums up all the expenses in the bucket
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
