// Importo el paquete formz para la validación de formularios
import 'package:formz/formz.dart';

// Defino un enum para los posibles errores de validación de la contraseña
enum PasswordValidationError { empty, tooShort, incorrect }

// Defino la clase Password que extiende FormzInput
// FormzInput es una clase genérica que toma dos tipos:
// 1. El tipo del valor de entrada (String en este caso)
// 2. El tipo del error de validación (PasswordValidationError en este caso)
class Password extends FormzInput<String, PasswordValidationError> {
  // Constructor para una contraseña pura (no modificada)
  const Password.pure()
      : _invalid = false,
        super.pure('');

  // Constructor para una contraseña modificada
  // Toma un valor opcional y un flag de invalidez
  const Password.dirty({String value = '', bool invalid = false})
      : _invalid = invalid,
        super.dirty(value);

  // Flag privado para indicar si la contraseña es inválida
  final bool _invalid;

  // Método de validación
  // Este método es llamado automáticamente por Formz
  @override
  PasswordValidationError? validator(String value) {
    // Si el valor está vacío, retorno el error 'empty'
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    // Si la longitud del valor es menor a 3, retorno el error 'tooShort'
    if (value.length < 3) {
      return PasswordValidationError.tooShort;
    }
    // Si la contraseña es inválida y no es 'admin', retorno el error 'incorrect'
    if (_invalid && value != 'admin') {
      return PasswordValidationError.incorrect;
    }
    // Si pasa todas las validaciones, retorno null (sin error)
    return null;
  }
}
