// Importo el paquete formz que proporciona utilidades para la validación de formularios
import 'package:formz/formz.dart';

// Defino un enum para los posibles errores de validación del email
enum EmailValidationError { empty, invalid, incorrect }

// Defino la clase Email que extiende FormzInput
// FormzInput es una clase genérica que toma dos tipos:
// 1. El tipo del valor de entrada (String en este caso)
// 2. El tipo del error de validación (EmailValidationError en este caso)
class Email extends FormzInput<String, EmailValidationError> {
  // Constructor para un email puro (no modificado)
  const Email.pure()
      : _invalid = false,
        super.pure('');

  // Constructor para un email modificado
  // Toma un valor opcional y un flag de invalidez
  const Email.dirty({String value = '', bool invalid = false})
      : _invalid = invalid,
        super.dirty(value);

  // Flag privado para indicar si el email es inválido
  final bool _invalid;

  // Expresión regular para validar el formato del email
  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");

  // Método de validación
  // Este método es llamado automáticamente por Formz
  @override
  EmailValidationError? validator(String value) {
    // Si el valor está vacío, retorno el error 'empty'
    if (value.isEmpty) {
      return EmailValidationError.empty;
    }
    // Si el valor no coincide con el formato de email, retorno el error 'invalid'
    if (!_emailRegExp.hasMatch(value)) {
      return EmailValidationError.invalid;
    }
    // Si el email es inválido y no es 'admin', retorno el error 'incorrect'
    if (_invalid && value != 'mbarra@gmail.com') {
      return EmailValidationError.incorrect;
    }
    // Si pasa todas las validaciones, retorno null (sin error)
    return null;
  }
}
