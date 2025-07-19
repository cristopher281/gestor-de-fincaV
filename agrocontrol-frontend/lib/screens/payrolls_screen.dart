import 'package:flutter/material.dart';
import '../services/payroll_service.dart';
import '../widgets/add_payroll_form.dart';

class PayrollsScreen extends StatefulWidget {
  const PayrollsScreen({super.key});

  @override
  State<PayrollsScreen> createState() => _PayrollsScreenState();
}

class _PayrollsScreenState extends State<PayrollsScreen> {
  List payrolls = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchPayrolls();
  }

  Future<void> fetchPayrolls() async {
    final data = await PayrollService().getPayrolls();
    setState(() {
      payrolls = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Planillas', style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold)),
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
                itemCount: payrolls.length,
                itemBuilder: (context, i) {
                  final p = payrolls[i];
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    color: Colors.white.withOpacity(0.08),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: const Icon(Icons.assignment, color: Colors.cyanAccent, size: 36),
                      title: Text(
                        'Trabajador: ${p['trabajador_id'] ?? ''}',
                        style: const TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Semana: ${p['semana_inicio']?.toString().substring(0,10) ?? ''} - ${p['semana_fin']?.toString().substring(0,10) ?? ''}', style: const TextStyle(color: Colors.cyanAccent)),
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
            builder: (context) => AddPayrollForm(onPayrollAdded: fetchPayrolls),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
