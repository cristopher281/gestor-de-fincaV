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
      appBar: AppBar(title: const Text('Compras')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: purchases.length,
              itemBuilder: (context, i) {
                final p = purchases[i];
                return ListTile(
                  title: Text(p['producto'] ?? ''),
                  subtitle: Text('Proveedor: ${p['proveedor'] ?? ''}\nTotal: ${p['costo_total'] ?? ''}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => AddPurchaseForm(onPurchaseAdded: fetchPurchases),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
