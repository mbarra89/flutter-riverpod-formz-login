// Importo los paquetes necesarios de Flutter y Riverpod
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
// Importo la pantalla de login que hemos definido anteriormente
import 'package:login_form/presentation/screens/login_screen.dart';

final _log = Logger('main');

// Función principal que inicia la aplicación
void main() {
  // Configura el logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    _log.info('${record.level.name}: ${record.time}: ${record.message}');
  });
  // Ejecuto la aplicación envuelta en un ProviderScope
  // ProviderScope es necesario para que Riverpod funcione en toda la app
  runApp(const ProviderScope(child: MyApp()));
}

// Defino la clase MyApp que es el widget raíz de la aplicación
class MyApp extends StatelessWidget {
  // Constructor de MyApp
  const MyApp({super.key});

  // Sobrescribo el método build para definir la estructura de la app
  @override
  Widget build(BuildContext context) {
    // Retorno un MaterialApp, que proporciona muchas funcionalidades básicas de Material Design
    return MaterialApp(
      // Título de la aplicación, se usa en la tarea reciente de Android
      title: 'Empatia Industries',
      // Desactivo el banner de depuración en la esquina
      debugShowCheckedModeBanner: false,
      // Defino el tema de la aplicación
      theme: ThemeData(
        // Establezco el color primario, que se usa en el botón principal
        primaryColor: const Color(0xFF2196F3), // Color rojo oscuro del botón
        // Establezco el color de fondo del Scaffold
        scaffoldBackgroundColor: Colors.white,
      ),
      // Establezco LoginScreen como la pantalla inicial de la app
      home: const LoginScreen(),
    );
  }
}
