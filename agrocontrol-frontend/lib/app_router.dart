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
      appBar: AppBar(title: const Text('Menú Principal')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Trabajadores'),
            onTap: () => Navigator.pushNamed(context, '/workers'),
          ),
          ListTile(
            title: const Text('Planillas'),
            onTap: () => Navigator.pushNamed(context, '/payrolls'),
          ),
          ListTile(
            title: const Text('Préstamos'),
            onTap: () => Navigator.pushNamed(context, '/loans'),
          ),
          ListTile(
            title: const Text('Compras'),
            onTap: () => Navigator.pushNamed(context, '/purchases'),
          ),
          ListTile(
            title: const Text('Inversiones'),
            onTap: () => Navigator.pushNamed(context, '/investments'),
          ),
          ListTile(
            title: const Text('Ingresos'),
            onTap: () => Navigator.pushNamed(context, '/incomes'),
          ),
        ],
      ),
    );
  }
}
