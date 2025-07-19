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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Trabajadores', style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF232526), Color(0xFF0f2027)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: loading
            ? const Center(child: CircularProgressIndicator(color: Colors.cyanAccent))
            : ListView.builder(
                padding: const EdgeInsets.only(top: 90, left: 16, right: 16, bottom: 16),
                itemCount: workers.length,
                itemBuilder: (context, i) {
                  final w = workers[i];
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    color: Colors.white.withOpacity(0.08),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.cyanAccent, size: 36),
                      title: Text(
                        w['nombre'] ?? '',
                        style: const TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cédula: ${w['cedula'] ?? ''}', style: const TextStyle(color: Colors.cyanAccent)),
                          Text('Contacto: ${w['contacto'] ?? ''}', style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => AddWorkerForm(onWorkerAdded: fetchWorkers),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
