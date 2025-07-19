import 'package:flutter/material.dart';
import '../services/loan_service.dart';
import 'worker_dropdown.dart';

class AddLoanForm extends StatefulWidget {
  final VoidCallback onLoanAdded;
  const AddLoanForm({super.key, required this.onLoanAdded});

  @override
  State<AddLoanForm> createState() => _AddLoanFormState();
}

  final _formKey = GlobalKey<FormState>();
  double monto = 0;
  DateTime fecha = DateTime.now();
  String? trabajadorId;
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar Préstamo'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WorkerDropdown(
                onSelected: (id) => trabajadorId = id,
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
                    if (trabajadorId == null) {
                      setState(() { error = 'Seleccione un trabajador'; });
                      return;
                    }
                    final result = await LoanService().addLoan({
                      'trabajador_id': trabajadorId,
                      'monto': monto,
                      'fecha': fecha.toIso8601String(),
                      'abonos': [],
                      'saldo_actual': monto,
                    });
                    setState(() { loading = false; });
                    if (result == true) {
                      widget.onLoanAdded();
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
