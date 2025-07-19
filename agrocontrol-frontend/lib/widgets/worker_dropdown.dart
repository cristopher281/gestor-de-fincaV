import 'package:flutter/material.dart';
import '../services/worker_service.dart';

class WorkerDropdown extends StatefulWidget {
  final Function(String) onSelected;
  final String? initialValue;
  const WorkerDropdown({super.key, required this.onSelected, this.initialValue});

  @override
  State<WorkerDropdown> createState() => _WorkerDropdownState();
}

class _WorkerDropdownState extends State<WorkerDropdown> {
  List workers = [];
  String? selected;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchWorkers();
  }

  Future<void> fetchWorkers() async {
    final data = await WorkerService().getWorkers();
    setState(() {
      workers = data;
      selected = widget.initialValue;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const CircularProgressIndicator();
    return DropdownButtonFormField<String>(
      value: selected,
      items: workers.map<DropdownMenuItem<String>>((w) {
        return DropdownMenuItem<String>(
          value: w['_id'],
          child: Text(w['nombre'] ?? ''),
        );
      }).toList(),
      onChanged: (val) {
        setState(() => selected = val);
        if (val != null) widget.onSelected(val);
      },
      decoration: const InputDecoration(labelText: 'Trabajador'),
      validator: (val) => val == null ? 'Seleccione un trabajador' : null,
    );
  }
}
