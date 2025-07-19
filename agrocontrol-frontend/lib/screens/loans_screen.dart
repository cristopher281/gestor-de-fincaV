import 'package:flutter/material.dart';
import '../services/loan_service.dart';
import '../widgets/add_loan_form.dart';

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen> {
  List loans = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchLoans();
  }

  Future<void> fetchLoans() async {
    final data = await LoanService().getLoans();
    setState(() {
      loans = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Préstamos')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: loans.length,
              itemBuilder: (context, i) {
                final loan = loans[i];
                return ListTile(
                  title: Text('Trabajador: ${loan['trabajador_id'] ?? ''}'),
                  subtitle: Text('Monto: ${loan['monto'] ?? ''} | Saldo: ${loan['saldo_actual'] ?? ''}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Para demo, se debe seleccionar un trabajador válido
          await showDialog(
            context: context,
            builder: (context) => AddLoanForm(
              trabajadorId: '', // Debe integrarse con selección de trabajador
              onLoanAdded: fetchLoans,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
