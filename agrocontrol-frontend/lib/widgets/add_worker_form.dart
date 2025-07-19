import 'package:flutter/material.dart';
import '../services/worker_service.dart';

class AddWorkerForm extends StatefulWidget {
  final VoidCallback onWorkerAdded;
  const AddWorkerForm({super.key, required this.onWorkerAdded});

  @override
  State<AddWorkerForm> createState() => _AddWorkerFormState();
}

class _AddWorkerFormState extends State<AddWorkerForm> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  String cedula = '';
  String contacto = '';
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Trabajador'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nombre'),
              onChanged: (val) => nombre = val,
              validator: (val) => val!.isEmpty ? 'Ingrese el nombre' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Cédula'),
              onChanged: (val) => cedula = val,
              validator: (val) => val!.isEmpty ? 'Ingrese la cédula' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Contacto'),
              onChanged: (val) => contacto = val,
            ),
            if (error != null) ...[
              const SizedBox(height: 10),
              Text(error!, style: const TextStyle(color: Colors.red)),
            ],
          ],
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
                    final result = await WorkerService().addWorker({
                      'nombre': nombre,
                      'cedula': cedula,
                      'contacto': contacto,
                    });
                    setState(() { loading = false; });
                    if (result == true) {
                      widget.onWorkerAdded();
                      Navigator.pop(context);
                    } else {
                      setState(() { error = result.toString(); });
                    }
                  }
                },
                child: const Text('Agregar'),
              ),
      ],
    );
  }
}
