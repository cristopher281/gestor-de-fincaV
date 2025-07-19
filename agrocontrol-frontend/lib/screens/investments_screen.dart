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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Inversiones', style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold)),
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
                itemCount: investments.length,
                itemBuilder: (context, i) {
                  final inv = investments[i];
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    color: Colors.white.withOpacity(0.08),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: const Icon(Icons.trending_up, color: Colors.cyanAccent, size: 36),
                      title: Text(
                        inv['concepto'] ?? '',
                        style: const TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Text('Monto: ${inv['monto'] ?? ''}', style: const TextStyle(color: Colors.cyanAccent)),
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
            builder: (context) => AddInvestmentForm(onInvestmentAdded: fetchInvestments),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
