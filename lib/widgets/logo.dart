// Importo el paquete de Flutter para usar widgets y otros elementos de la interfaz de usuario
import 'package:flutter/material.dart';

// Defino una clase llamada Logo que hereda de StatelessWidget
// StatelessWidget es un widget que no cambia su estado interno
class Logo extends StatelessWidget {
  // Constructor de la clase Logo
  // El parámetro key es opcional y se usa para identificar widgets en el árbol de widgets
  const Logo({super.key});

  // Sobrescribo el método build que es obligatorio en los widgets de Flutter
  // Este método describe cómo se debe construir el widget
  @override
  Widget build(BuildContext context) {
    // Retorno un Container que es un widget básico para contener otros widgets
    return Container(
      // Añado un padding en la parte inferior del contenedor de 40 unidades lógicas
      padding: const EdgeInsets.only(bottom: 40),
      // Dentro del contenedor, coloco un widget Transform.translate
      // Este widget me permite mover su hijo sin cambiar su tamaño
      child: Transform.translate(
          // Muevo el widget hijo 125 unidades a la izquierda
          offset: const Offset(0, 0),
          // El hijo del Transform.translate es una imagen
          child: Image.asset(
            // Especifico la ruta de la imagen en los assets del proyecto
            'assets/images/logo_placeholder.png',
            // Establezco la altura de la imagen a 100 unidades lógicas
            height: 100,
          )),
    );
  }
}
