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
      appBar: AppBar(title: const Text('Planillas')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: payrolls.length,
              itemBuilder: (context, i) {
                final p = payrolls[i];
                return ListTile(
                  title: Text('Trabajador: ${p['trabajador_id'] ?? ''}'),
                  subtitle: Text('Semana: ${p['semana_inicio'] ?? ''} - ${p['semana_fin'] ?? ''}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Para demo, se debe seleccionar un trabajador válido
          await showDialog(
            context: context,
            builder: (context) => AddPayrollForm(
              trabajadorId: '', // Debe integrarse con selección de trabajador
              onPayrollAdded: fetchPayrolls,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
