// Importo los paquetes necesarios de Flutter y mis propios archivos
import 'package:flutter/material.dart';
import 'package:login_form/presentation/screens/login_form.dart';
import 'package:login_form/widgets/logo.dart';

// Defino la clase LoginScreen que hereda de StatelessWidget
class LoginScreen extends StatelessWidget {
  // Constructor de LoginScreen
  const LoginScreen({super.key});

  // Sobrescribo el método build para describir cómo se construye este widget
  @override
  Widget build(BuildContext context) {
    // Retorno un Scaffold, que es un widget que implementa la estructura visual básica de Material Design
    return Scaffold(
      // En el cuerpo del Scaffold, coloco un GestureDetector
      body: GestureDetector(
        // Cuando se toca cualquier parte fuera de los campos de texto, se quita el foco
        onTap: () => FocusScope.of(context).unfocus(),
        // Dentro del GestureDetector, uso un SafeArea para evitar interferencias con áreas del sistema como la barra de estado
        child: const SafeArea(
          // Añado un padding horizontal de 20 unidades a todo el contenido
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            // Uso una Column para organizar los widgets verticalmente
            child: Column(
              children: [
                // Añado un espacio en blanco de 40 unidades al principio
                SizedBox(height: 40),
                // Inserto el widget Logo que definí anteriormente
                Logo(),
                // Otro espacio en blanco de 20 unidades
                SizedBox(height: 20),
                // Texto de bienvenida con estilo personalizado
                Text(
                  'Buenas tardes!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // Subtítulo con estilo personalizado
                Text(
                  '¿Cómo has estado?',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                // Más espacio en blanco
                SizedBox(height: 40),
                // Inserto el widget LoginForm (que aún no hemos definido)
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
