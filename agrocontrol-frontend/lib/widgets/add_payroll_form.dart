import 'package:flutter/material.dart';
import '../services/payroll_service.dart';

class AddPayrollForm extends StatefulWidget {
  final VoidCallback onPayrollAdded;
  final String trabajadorId;
  const AddPayrollForm({super.key, required this.onPayrollAdded, required this.trabajadorId});

  @override
  State<AddPayrollForm> createState() => _AddPayrollFormState();
}

class _AddPayrollFormState extends State<AddPayrollForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime semanaInicio = DateTime.now();
  DateTime semanaFin = DateTime.now().add(const Duration(days: 6));
  String actividad = '';
  int produccion = 0;
  double pago = 0;
  String estadoPago = 'Pendiente';
  DateTime fecha = DateTime.now();
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar Planilla'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text('Semana inicio: '),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: semanaInicio,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => semanaInicio = picked);
                    },
                    child: Text('${semanaInicio.day}/${semanaInicio.month}/${semanaInicio.year}'),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Semana fin: '),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: semanaFin,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => semanaFin = picked);
                    },
                    child: Text('${semanaFin.day}/${semanaFin.month}/${semanaFin.year}'),
                  ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Actividad'),
                onChanged: (val) => actividad = val,
                validator: (val) => val!.isEmpty ? 'Ingrese la actividad' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Producción'),
                keyboardType: TextInputType.number,
                onChanged: (val) => produccion = int.tryParse(val) ?? 0,
                validator: (val) => val!.isEmpty ? 'Ingrese la producción' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Pago'),
                keyboardType: TextInputType.number,
                onChanged: (val) => pago = double.tryParse(val) ?? 0,
                validator: (val) => val!.isEmpty ? 'Ingrese el pago' : null,
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
              DropdownButtonFormField<String>(
                value: estadoPago,
                items: const [
                  DropdownMenuItem(value: 'Pagado', child: Text('Pagado')),
                  DropdownMenuItem(value: 'Pendiente', child: Text('Pendiente')),
                ],
                onChanged: (val) => setState(() => estadoPago = val ?? 'Pendiente'),
                decoration: const InputDecoration(labelText: 'Estado de pago'),
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
                    final result = await PayrollService().addPayroll({
                      'semana_inicio': semanaInicio.toIso8601String(),
                      'semana_fin': semanaFin.toIso8601String(),
                      'trabajador_id': widget.trabajadorId,
                      'registros_pago': [
                        {
                          'fecha': fecha.toIso8601String(),
                          'actividad': actividad,
                          'produccion': produccion,
                          'pago': pago,
                          'estado_pago': estadoPago,
                        }
                      ],
                    });
                    setState(() { loading = false; });
                    if (result == true) {
                      widget.onPayrollAdded();
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
