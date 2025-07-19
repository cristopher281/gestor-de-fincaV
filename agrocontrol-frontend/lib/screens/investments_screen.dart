import 'package:flutter/material.dart';
import '../services/investment_service.dart';
import '../widgets/add_investment_form.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({super.key});

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  List investments = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchInvestments();
  }

  Future<void> fetchInvestments() async {
    final data = await InvestmentService().getInvestments();
    setState(() {
      investments = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inversiones')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: investments.length,
              itemBuilder: (context, i) {
                final inv = investments[i];
                return ListTile(
                  title: Text(inv['concepto'] ?? ''),
                  subtitle: Text('Monto: ${inv['monto'] ?? ''}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => AddInvestmentForm(onInvestmentAdded: fetchInvestments),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
