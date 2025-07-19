import 'package:flutter/material.dart';
import '../services/worker_service.dart';
import '../widgets/add_worker_form.dart';

class WorkersScreen extends StatefulWidget {
  const WorkersScreen({super.key});

  @override
  State<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  List workers = [];
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
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trabajadores')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: workers.length,
              itemBuilder: (context, i) {
                final w = workers[i];
                return ListTile(
                  title: Text(w['nombre'] ?? ''),
                  subtitle: Text('Cédula: ${w['cedula'] ?? ''}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => AddWorkerForm(onWorkerAdded: fetchWorkers),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
