import 'package:expense_tracker/widgets/expense/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.item});

  final Expense item;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              item.title,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${item.amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      categoryIcons[item.category],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(item.getDateInFormate),
                  ],
                )
              ],
            )
          ])),
    ));
  }
}
