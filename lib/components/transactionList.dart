import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../klase/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions = [];

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 17, 10, 17),
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(7)),
                  child: Text(
                    '${transactions[index].amount.toStringAsFixed(2)} €',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactions[index].title,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      DateFormat('d MMMM y').format(transactions[index].date),
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
