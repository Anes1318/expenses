import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final label;
  final double spendingAmount;
  final double procent;
  const ChartBar(
      {required this.label,
      required this.spendingAmount,
      required this.procent});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.09,
              child: FittedBox(
                child: Text('${spendingAmount.toStringAsFixed(0)}€'),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.03),
            Container(
                height: constraints.maxHeight * 0.7,
                width: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: procent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: constraints.maxHeight * 0.03),
            Container(
              height: constraints.maxHeight * 0.09,
              child: FittedBox(child: Text('$label')),
            ),
          ],
        );
      },
    );
  }
}
