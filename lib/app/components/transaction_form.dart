import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _valueController = TextEditingController();
  final _titleController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  _subimitForm() {
    final title = _titleController.text;
    final double value = double.tryParse(_valueController.text) ?? 0.0;
    // ignore: unnecessary_null_comparison
    if (title.isEmpty || value <= 0 || _selectDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectDate);
  }

  _showDatePicker() async {
    DateTime? alterandoValor = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime.now(),
    );
    setState(() {
      _selectDate = alterandoValor!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                labelText: 'Título',
              ),
              controller: _titleController,
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
              controller: _valueController,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      _selectDate == null
                          ? 'Nenhuma data selecionada!'
                          : "Data selecionada: ${DateFormat('dd/MM/yyyy').format(_selectDate)}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _showDatePicker();
                    },
                    child: const Text(
                      'Selecionar Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.topRight,
              child: FilledButton(
                  onPressed: _subimitForm,
                  child: const Text(
                    'Adicionar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
