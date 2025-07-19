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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Préstamos', style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold)),
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
                itemCount: loans.length,
                itemBuilder: (context, i) {
                  final loan = loans[i];
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    color: Colors.white.withOpacity(0.08),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: const Icon(Icons.account_balance_wallet, color: Colors.cyanAccent, size: 36),
                      title: Text(
                        'Trabajador: ${loan['trabajador_id'] ?? ''}',
                        style: const TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Monto: ${loan['monto'] ?? ''}', style: const TextStyle(color: Colors.cyanAccent)),
                          Text('Saldo: ${loan['saldo_actual'] ?? ''}', style: const TextStyle(color: Colors.white70)),
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
            builder: (context) => AddLoanForm(onLoanAdded: fetchLoans),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
