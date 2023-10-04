import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/models/expense.dart';

/// Chart widget that represents the chart
class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  /// The expenses to be used for the chart
  final List<Expense> expenses;

  /// A getter that returns a list of expense buckets based of the categories
  List<ExpenseBucket> get buckets {
    List<ExpenseBucket> buckets = [];
    for (final category in Category.values) {
      buckets.add(ExpenseBucket.forCategory(expenses, category));
    }
    return buckets;
  }

  /// A getter that returns the maximum total expense of all buckets
  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity, //Take whole width
      height: 180, // Fixed height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter, // Start from bottom
          end: Alignment.topCenter, // End at top
        ),
      ),
      //Split into 3 columns
      child: Column(
        children: [
          //Take the full length of the row
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          // Add some space
          const SizedBox(height: 12),
          // Add another row with the icons at the bottom
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        bucket.category.icon,
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
