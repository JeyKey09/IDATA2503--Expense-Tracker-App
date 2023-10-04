import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenseMenu.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

/// A representation of the expenses screen.
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

/// A state class for the expenses screen.
class _ExpensesState extends State<Expenses> {
  /// A list of registered expenses.
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  /// A function that opens the add expense overlay.
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => ExpenseMenu(onFinishedExpense: _addExpense),
    );
  }

  /// A function that adds an expense to the list of registered expenses.
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  /// A function that removes an expense from the list of registered expenses.
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  /// A function that opens the edit expense overlay.
  void _openEditExpenseOverlay(Expense expense) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => ExpenseMenu(
        onFinishedExpense: _editExpense,
        itemToEdit: expense,
      ),
    );
  }

  /// A function that edits an expense in the list of registered expenses.
  void _editExpense(Expense expense) {
    setState(() {
      final expenseIndex = _registeredExpenses.indexWhere(
        (element) => element.id == expense.id,
      );
      //_registeredExpenses.removeAt(expenseIndex);
      _registeredExpenses[expenseIndex] = expense;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
        onEditExpense: _openEditExpenseOverlay,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
