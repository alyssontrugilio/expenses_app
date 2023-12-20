import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final valueController = TextEditingController();

  final titleController = TextEditingController();

  _subimitForm() {
    final title = titleController.text;
    final double value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

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
              onSubmitted: (_) => _subimitForm(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Valor (R\$)',
              ),
              controller: valueController,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: _subimitForm,
                child: const Text(
                  'Adicionar',
                  style: TextStyle(),
                ))
          ],
        ),
      ),
    );
  }
}
