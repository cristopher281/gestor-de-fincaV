import 'package:flutter/material.dart';
import '../services/purchase_service.dart';
import '../widgets/add_purchase_form.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  List purchases = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchPurchases();
  }

  Future<void> fetchPurchases() async {
    final data = await PurchaseService().getPurchases();
    setState(() {
      purchases = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Compras', style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f2027), Color(0xFF2c5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: loading
            ? const Center(child: CircularProgressIndicator(color: Colors.cyanAccent))
            : ListView.builder(
                padding: const EdgeInsets.only(top: 90, left: 16, right: 16, bottom: 16),
                itemCount: purchases.length,
                itemBuilder: (context, i) {
                  final p = purchases[i];
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    color: Colors.white.withOpacity(0.08),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: const Icon(Icons.shopping_cart_checkout, color: Colors.cyanAccent, size: 36),
                      title: Text(
                        p['producto'] ?? '',
                        style: const TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Proveedor: ${p['proveedor'] ?? ''}', style: const TextStyle(color: Colors.cyanAccent)),
                          Text('Total: ${p['costo_total'] ?? ''}', style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                      trailing: Text(
                        p['fecha'] != null ? p['fecha'].toString().substring(0, 10) : '',
                        style: const TextStyle(color: Colors.cyanAccent, fontFamily: 'Orbitron'),
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
            builder: (context) => AddPurchaseForm(onPurchaseAdded: fetchPurchases),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
