import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/workers_screen.dart';
import 'screens/register_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/workers':
        return MaterialPageRoute(builder: (_) => const WorkersScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/login':
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/login',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
