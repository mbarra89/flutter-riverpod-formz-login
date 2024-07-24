// Importo los paquetes necesarios de Flutter y mis propios archivos
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:login_form/domain/entities/email.dart';
import 'package:login_form/domain/entities/password.dart';
import 'package:login_form/presentation/providers/login_controller.dart';

// Creo una clave global para el formulario
// Esto me permitirá acceder y validar el formulario desde cualquier parte de este widget
final _formKey = GlobalKey<FormState>();

// Defino LoginForm como un ConsumerWidget
// ConsumerWidget es un widget que puede escuchar a los providers de Riverpod
class LoginForm extends ConsumerWidget {
  // Constructor de LoginForm
  const LoginForm({super.key});

  // Sobrescribo el método build
  // Recibo el contexto y una referencia al WidgetRef de Riverpod
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observo el estado del loginControllerProvider
    final state = ref.watch(loginControllerProvider);
    // Obtengo una referencia al controlador del loginControllerProvider
    final controller = ref.read(loginControllerProvider.notifier);

    // Retorno un widget Form que agrupa y valida múltiples campos de formulario
    return Form(
      // Asigno la clave global al formulario
      key: _formKey,
      // Dentro del formulario, uso una Column para organizar los widgets verticalmente
      child: Column(
        // Alineo los hijos de la columna al inicio horizontalmente
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Etiqueta para el campo de email
          const Text('Email', style: TextStyle(color: Colors.grey)),
          // Campo de texto para el email
          TextFormField(
            // Cuando el texto cambia, llamo al método emailChanged del controlador
            onChanged: controller.emailChanged,
            // Configuro la decoración del campo de texto
            decoration: const InputDecoration(
              hintText: 'example@gmail.com',
              border: UnderlineInputBorder(),
            ),
            // Defino el validador del campo
            validator: (_) => state.email.error == null
                ? null
                : _getEmailErrorMessage(state.email.error!),
          ),
          // Espacio entre campos
          const SizedBox(height: 20),
          // Etiqueta para el campo de contraseña
          const Text('Contraseña', style: TextStyle(color: Colors.grey)),
          // Campo de texto para la contraseña
          TextFormField(
            // Cuando el texto cambia, llamo al método passwordChanged del controlador
            onChanged: controller.passwordChanged,
            // Oculto el texto ingresado
            obscureText: true,
            // Configuro la decoración del campo de texto
            decoration: const InputDecoration(
              hintText: '••••••••••••••••••••••••••••••••••••••',
              border: UnderlineInputBorder(),
            ),
            // Defino el validador del campo
            validator: (_) => state.password.error == null
                ? null
                : _getPasswordErrorMessage(state.password.error!),
          ),
          // Espacio antes del botón
          const SizedBox(height: 40),
          // Botón de ingreso
          ElevatedButton(
            // Cuando se presiona el botón, valido el formulario y llamo al método login del controlador
            onPressed: state.status == FormzSubmissionStatus.inProgress
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(loginControllerProvider.notifier).login();
                    }
                  },

            // Estilo del botón
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text('Ingresar'),
          ),
          // Si el estado del formulario es de fallo, muestro un mensaje de error
          if (state.status == FormzSubmissionStatus.failure)
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Credenciales incorrectas. Por favor, vuelva a intentarlo.',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          // Si el estado del formulario es de éxito, muestro un mensaje con las credenciales
          if (state.status == FormzSubmissionStatus.success)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                state.successMessage!,
                style: const TextStyle(color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ),
          // Espacio adicional
          const SizedBox(height: 20),
          // Botón para recuperar contraseña
          TextButton(
            onPressed: () {},
            child: const Text('¿Olvidaste tu contraseña?',
                style: TextStyle(color: Colors.black87)),
          ),
          // Botón para ver términos y condiciones
          TextButton(
            onPressed: () {},
            child: const Text('Términos y condiciones',
                style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  // Método auxiliar para obtener el mensaje de error del email
  String _getEmailErrorMessage(EmailValidationError error) {
    switch (error) {
      case EmailValidationError.empty:
        return 'El email no puede estar vacío';
      case EmailValidationError.invalid:
        return 'Ingrese un email no es valido';
      case EmailValidationError.incorrect:
        return 'Email incorrecto';
    }
  }

  // Método auxiliar para obtener el mensaje de error de la contraseña
  String _getPasswordErrorMessage(PasswordValidationError error) {
    switch (error) {
      case PasswordValidationError.empty:
        return 'La contraseña no puede estar vacía';
      case PasswordValidationError.tooShort:
        return 'La contraseña debe tener al menos 6 caracteres';
      case PasswordValidationError.incorrect:
        return 'Contraseña incorrecta';
    }
  }
}
