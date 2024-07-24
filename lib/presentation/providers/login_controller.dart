// Importo los paquetes necesarios
import 'dart:convert';

import 'package:formz/formz.dart';
import 'package:logging/logging.dart';
import 'package:login_form/data/repositories/auth_repository.dart';
import 'package:login_form/domain/entities/email.dart';
import 'package:login_form/domain/entities/password.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Esta línea genera el código para el provider
part 'login_controller.g.dart';

// Creamos un logger para esta clase
final _log = Logger('LoginController');

String encryptPassword(String password) {
  return base64.encode(utf8.encode(password));
}

String decryptPassword(String encryptedPassword) {
  return utf8.decode(base64.decode(encryptedPassword));
}

// Defino el LoginController como un provider de Riverpod
@riverpod
class LoginController extends _$LoginController {
  // Método build que define el estado inicial del controlador
  @override
  LoginState build() => const LoginState();

  // Método que se llama cuando cambia el email
  void emailChanged(String value) {
    // Creo una nueva instancia de Email con el valor actual
    final email = Email.dirty(value: value);
    // Actualizo el estado con el nuevo email y valido el formulario
    state = state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password]),
    );
  }

  // Método que se llama cuando cambia la contraseña
  void passwordChanged(String value) {
    // Creo una nueva instancia de Password con el valor actual
    final password = Password.dirty(value: value);
    // Actualizo el estado con la nueva contraseña y valido el formulario
    state = state.copyWith(
      password: password,
      isValid: Formz.validate([state.email, password]),
    );
  }

  // Método que maneja el proceso de login
  Future<void> login() async {
    // Si el formulario no es válido, no hago nada
    if (!state.isValid) return;

    // Cambio el estado a "en progreso"
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);

    String encryptedPassword = encryptPassword(state.password.value);

    try {
      // Desencripto la contraseña
      String decryptedPassword = decryptPassword(encryptedPassword);

      // Simulo un retraso de 2 segundos como si fuera una llamada a una API
      await Future.delayed(const Duration(seconds: 2));

      // Intento hacer login usando el AuthRepository
      final success = await ref.read(authRepositoryProvider).login(
            state.email.value,
            // state.password.value,
            decryptedPassword,
          );

      // Si el login es exitoso, actualizo el estado a "éxito"
      if (success) {
        state = state.copyWith(
            status: FormzSubmissionStatus.success,
            successMessage:
                'Inicio de sesión exitoso. Credenciales: ${state.email.value}, ${state.password.value}');

        // String encryptedPassword = encryptPassword(state.password.value);

        Map<String, String> credentials = {
          'email': state.email.value,
          'password': state.password.value
        };

        String jsonBody = jsonEncode(credentials);

        // Usamos el logger en lugar de print
        _log.info('Login exitoso. Datos enviados: , $jsonBody');
      } else {
        // Si el login falla, marco el email y la contraseña como inválidos
        state = state.copyWith(
          status: FormzSubmissionStatus.failure,
          email: Email.dirty(value: state.email.value, invalid: true),
          password: Password.dirty(value: state.password.value, invalid: true),
        );
      }
    } catch (e) {
      _log.severe('Error al hacer login', e);
      // Si ocurre un error, actualizo el estado a "fallo"
      state = state.copyWith(status: FormzSubmissionStatus.failure);
    }
  }
}

// Defino la clase LoginState para manejar el estado del login
class LoginState {
  // Constructor con valores por defecto
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.successMessage,
  });

  // Propiedades del estado
  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? successMessage;

  // Método para crear una nueva instancia de LoginState con propiedades actualizadas
  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? successMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
