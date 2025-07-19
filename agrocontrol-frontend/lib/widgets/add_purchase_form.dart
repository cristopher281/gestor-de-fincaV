import 'package:flutter/material.dart';
import '../services/purchase_service.dart';

class AddPurchaseForm extends StatefulWidget {
  final VoidCallback onPurchaseAdded;
  const AddPurchaseForm({super.key, required this.onPurchaseAdded});

  @override
  State<AddPurchaseForm> createState() => _AddPurchaseFormState();
}

class _AddPurchaseFormState extends State<AddPurchaseForm> {
  final _formKey = GlobalKey<FormState>();
  String producto = '';
  int cantidad = 1;
  double costoUnitario = 0;
  double costoTotal = 0;
  String proveedor = '';
  DateTime fecha = DateTime.now();
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar Compra'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Producto'),
                onChanged: (val) => producto = val,
                validator: (val) => val!.isEmpty ? 'Ingrese el producto' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                onChanged: (val) => cantidad = int.tryParse(val) ?? 1,
                validator: (val) => val!.isEmpty ? 'Ingrese la cantidad' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Costo unitario'),
                keyboardType: TextInputType.number,
                onChanged: (val) => costoUnitario = double.tryParse(val) ?? 0,
                validator: (val) => val!.isEmpty ? 'Ingrese el costo unitario' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Costo total'),
                keyboardType: TextInputType.number,
                onChanged: (val) => costoTotal = double.tryParse(val) ?? 0,
                validator: (val) => val!.isEmpty ? 'Ingrese el costo total' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Proveedor'),
                onChanged: (val) => proveedor = val,
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
                    final result = await PurchaseService().addPurchase({
                      'producto': producto,
                      'cantidad': cantidad,
                      'costo_unitario': costoUnitario,
                      'costo_total': costoTotal,
                      'proveedor': proveedor,
                      'fecha': fecha.toIso8601String(),
                    });
                    setState(() { loading = false; });
                    if (result == true) {
                      widget.onPurchaseAdded();
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
