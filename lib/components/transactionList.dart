import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../klase/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions = [];
  final Function deleteList;

  TransactionList(this.transactions, this.deleteList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: (transactions.isEmpty)
          ? Column(
              children: [
                Text(
                  'Empty...',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              minWidth: 50,
                              minHeight: 50,
                              maxWidth: 90,
                              maxHeight: 90,
                            ),
                            // padding: EdgeInsets.all(30),
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(7)),
                            child: FittedBox(
                              child: Text(
                                '${transactions[index].amount.toStringAsFixed(1)} €',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transactions[index].title,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                DateFormat('d MMMM y')
                                    .format(transactions[index].date),
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => deleteList(transactions[index].id),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey.shade700,
                        ),
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
