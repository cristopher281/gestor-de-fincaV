import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/workers_screen.dart';
import 'screens/register_screen.dart';
import 'screens/purchases_screen.dart';
import 'screens/investments_screen.dart';
import 'screens/incomes_screen.dart';
import 'screens/loans_screen.dart';
import 'screens/payrolls_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/workers':
        return MaterialPageRoute(builder: (_) => const WorkersScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainMenuScreen());
      case '/purchases':
        return MaterialPageRoute(builder: (_) => const PurchasesScreen());
      case '/investments':
        return MaterialPageRoute(builder: (_) => const InvestmentsScreen());
      case '/incomes':
        return MaterialPageRoute(builder: (_) => const IncomesScreen());
      case '/loans':
        return MaterialPageRoute(builder: (_) => const LoansScreen());
      case '/payrolls':
        return MaterialPageRoute(builder: (_) => const PayrollsScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/login':
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroControl',
      initialRoute: '/login',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Menú Principal', style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold)),
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
        child: ListView(
          padding: const EdgeInsets.only(top: 90, left: 16, right: 16, bottom: 16),
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.white.withOpacity(0.08),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.people, color: Colors.cyanAccent, size: 36),
                title: const Text('Trabajadores', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white)),
                onTap: () => Navigator.pushNamed(context, '/workers'),
              ),
            ),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.white.withOpacity(0.08),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.assignment, color: Colors.cyanAccent, size: 36),
                title: const Text('Planillas', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white)),
                onTap: () => Navigator.pushNamed(context, '/payrolls'),
              ),
            ),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.white.withOpacity(0.08),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet, color: Colors.cyanAccent, size: 36),
                title: const Text('Préstamos', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white)),
                onTap: () => Navigator.pushNamed(context, '/loans'),
              ),
            ),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.white.withOpacity(0.08),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.shopping_cart_checkout, color: Colors.cyanAccent, size: 36),
                title: const Text('Compras', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white)),
                onTap: () => Navigator.pushNamed(context, '/purchases'),
              ),
            ),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.white.withOpacity(0.08),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.trending_up, color: Colors.cyanAccent, size: 36),
                title: const Text('Inversiones', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white)),
                onTap: () => Navigator.pushNamed(context, '/investments'),
              ),
            ),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.white.withOpacity(0.08),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.attach_money, color: Colors.cyanAccent, size: 36),
                title: const Text('Ingresos', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white)),
                onTap: () => Navigator.pushNamed(context, '/incomes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
