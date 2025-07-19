import 'package:flutter/material.dart';
import '../services/income_service.dart';

class AddIncomeForm extends StatefulWidget {
  final VoidCallback onIncomeAdded;
  const AddIncomeForm({super.key, required this.onIncomeAdded});

  @override
  State<AddIncomeForm> createState() => _AddIncomeFormState();
}

class _AddIncomeFormState extends State<AddIncomeForm> {
  final _formKey = GlobalKey<FormState>();
  String concepto = '';
  int cantidad = 1;
  double monto = 0;
  DateTime fecha = DateTime.now();
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar Ingreso'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Concepto'),
                onChanged: (val) => concepto = val,
                validator: (val) => val!.isEmpty ? 'Ingrese el concepto' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                onChanged: (val) => cantidad = int.tryParse(val) ?? 1,
                validator: (val) => val!.isEmpty ? 'Ingrese la cantidad' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Monto'),
                keyboardType: TextInputType.number,
                onChanged: (val) => monto = double.tryParse(val) ?? 0,
                validator: (val) => val!.isEmpty ? 'Ingrese el monto' : null,
              ),
              Row(
                children: [
                  const Text('Fecha: '),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: fecha,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => fecha = picked);
                    },
                    child: Text('${fecha.day}/${fecha.month}/${fecha.year}'),
                  ),
                ],
              ),
              if (error != null) ...[
                const SizedBox(height: 10),
                Text(error!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        loading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() { loading = true; error = null; });
                    final result = await IncomeService().addIncome({
                      'concepto': concepto,
                      'cantidad': cantidad,
                      'monto': monto,
                      'fecha': fecha.toIso8601String(),
                    });
                    setState(() { loading = false; });
                    if (result == true) {
                      widget.onIncomeAdded();
                      Navigator.pop(context);
                    } else {
                      setState(() { error = result.toString(); });
                    }
                  }
                },
                child: const Text('Registrar'),
              ),
      ],
    );
  }
}
