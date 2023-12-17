import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final valueController = TextEditingController();
  final titleController = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Título',
              ),
              controller: titleController,
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Valor (R\$)',
              ),
              controller: valueController,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text(
                'Nova transação',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                final title = titleController.text;
                final double value =
                    double.tryParse(valueController.text) ?? 0.0;
                onSubmit(title, value);
              },
            )
          ],
        ),
      ),
    );
  }
}
