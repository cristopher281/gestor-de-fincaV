import 'package:flutter/material.dart';
import '../services/income_service.dart';
import '../widgets/add_income_form.dart';

class IncomesScreen extends StatefulWidget {
  const IncomesScreen({super.key});

  @override
  State<IncomesScreen> createState() => _IncomesScreenState();
}

class _IncomesScreenState extends State<IncomesScreen> {
  List incomes = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchIncomes();
  }

  Future<void> fetchIncomes() async {
    final data = await IncomeService().getIncomes();
    setState(() {
      incomes = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: incomes.length,
              itemBuilder: (context, i) {
                final inc = incomes[i];
                return ListTile(
                  title: Text(inc['concepto'] ?? ''),
                  subtitle: Text('Monto: ${inc['monto'] ?? ''}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => AddIncomeForm(onIncomeAdded: fetchIncomes),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
