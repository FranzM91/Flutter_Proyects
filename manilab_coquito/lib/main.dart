import 'package:flutter/material.dart';
import 'router/app_routes.dart';

void main() async {
  runApp(const BaseApp());
}
class BaseApp extends StatelessWidget {
  const BaseApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        primaryColorDark: Colors.blue[900],
        primaryColorLight: Colors.blue[100],
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: AppRoutes.inicialRoute,
      routes: AppRoutes.getAppRoutes(),
      onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
    );
  }
}