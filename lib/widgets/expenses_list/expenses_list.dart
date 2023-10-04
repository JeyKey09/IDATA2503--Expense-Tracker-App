import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:expense_tracker/models/expense.dart';

/// A representation of a list of expenses.
class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key,
      required this.expenses,
      required this.onRemoveExpense,
      required this.onEditExpense});

  /// A list of expenses.
  final List<Expense> expenses;

  /// A function that is called when an expense is removed.
  final void Function(Expense expense) onRemoveExpense;

  /// A function that is called when an expense is edited.
  final void Function(Expense expense) onEditExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: GestureDetector(
          child: ExpenseItem(expenses[index]),
          onTap: () {
            onEditExpense(expenses[index]);
          },
        ),
      ),
    );
  }
}
