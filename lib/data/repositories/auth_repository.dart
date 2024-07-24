// Importo el paquete de Riverpod para la gestión del estado
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Esta línea genera el código para el provider
part 'auth_repository.g.dart';

/// Repositorio que maneja la autenticación
class AuthRepository {
  /// Simula un proceso de login
  ///
  /// Retorna true si el username y password son 'admin'
  /// Añade un delay de 2 segundos para simular una llamada a API
  Future<bool> login(String username, String password) async {
    // Simulo un retraso de 2 segundos como si fuera una llamada a una API
    await Future.delayed(const Duration(seconds: 2));
    // Verifico si el username y password son 'admin'
    return username == 'mbarra@gmail.com' && password == 'admin';
  }
}

/// Provider global para el AuthRepository
/// Permite acceder a una instancia de AuthRepository en cualquier parte de la app
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository();
