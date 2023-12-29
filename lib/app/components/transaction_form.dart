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
  DateTime _selectedDate = DateTime.now();

  _subimitForm() {
    final title = _titleController.text;
    final double value = double.tryParse(_valueController.text) ?? 0.0;
    // ignore: unnecessary_null_comparison
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() async {
    DateTime? alterandoValor = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime.now(),
    );
    setState(() {
      _selectedDate = alterandoValor!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
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
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : "Data selecionada: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}",
                        style: TextStyle(
                            fontSize:
                                15 * MediaQuery.of(context).textScaleFactor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _showDatePicker();
                      },
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15 * MediaQuery.of(context).textScaleFactor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                      onPressed: _subimitForm,
                      child: const Text(
                        'Adicionar',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
