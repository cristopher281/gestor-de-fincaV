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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Ingresos', style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold)),
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
                itemCount: incomes.length,
                itemBuilder: (context, i) {
                  final inc = incomes[i];
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    color: Colors.white.withOpacity(0.08),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: const Icon(Icons.attach_money, color: Colors.cyanAccent, size: 36),
                      title: Text(
                        inc['concepto'] ?? '',
                        style: const TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Text('Monto: ${inc['monto'] ?? ''}', style: const TextStyle(color: Colors.cyanAccent)),
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
            builder: (context) => AddIncomeForm(onIncomeAdded: fetchIncomes),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
