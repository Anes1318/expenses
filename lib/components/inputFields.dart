import 'package:flutter/material.dart';

class InputFields extends StatefulWidget {
  final funkcija;
  InputFields({required this.funkcija});

  @override
  State<InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submit() {
    final unesenTitle = titleController.text;
    final unesenAmount = double.parse(amountController.text);

    if (unesenTitle.isEmpty || unesenAmount <= 0) {
      return;
    }

    widget.funkcija(unesenTitle, unesenAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submit(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submit(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: submit,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
