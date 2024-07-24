# Login Form Flutter App

Este proyecto es una aplicación de Flutter que implementa un formulario de inicio de sesión utilizando Riverpod para la gestión del estado.

## Requisitos previos

Antes de comenzar, asegúrate de tener instalado lo siguiente:

- Flutter SDK (versión 2.0.0 o superior)
- Dart SDK (versión 2.12.0 o superior)
- Un IDE (preferiblemente Android Studio o VS Code con las extensiones de Flutter y Dart)
- Git

## Configuración del proyecto

1. Clona el repositorio:
   `git clone https://github.com/tu-usuario/login-form-flutter.git`
2. Navega al directorio del proyecto:
   `cd login-form-flutter`
3. Obtén las dependencias del proyecto:
   `flutter pub get`

## Estructura del proyecto

El proyecto está organizado de la siguiente manera:

- `lib/`: Contiene el código fuente de la aplicación
- `data/`: Repositorios y fuentes de datos
- `domain/`: Entidades y lógica de negocio
- `presentation/`: Widgets, pantallas y providers
- `main.dart`: Punto de entrada de la aplicación
- `assets/`: Contiene recursos como imágenes
- `test/`: Contiene los archivos de prueba

## Ejecución de la aplicación

Para ejecutar la aplicación en modo de depuración:

1. Asegúrate de tener un emulador en funcionamiento o un dispositivo conectado.

2. Desde la raíz del proyecto, ejecuta:
   `flutter run`

## Ejecución de pruebas

Para ejecutar las pruebas unitarias:
`flutter test`

## Construcción de la aplicación

Para construir la aplicación en modo release:

```
flutter build apk  # para Android
flutter build ios  # para iOS
```

## Dependencias principales

- `flutter_riverpod`: Para la gestión del estado
- `formz`: Para la validación de formularios
- `logging`: Para el registro de eventos

Asegúrate de revisar el archivo `pubspec.yaml` para ver la lista completa de dependencias y sus versiones.

## Contribución

Si deseas contribuir a este proyecto, por favor:

1. Haz un fork del repositorio
2. Crea una nueva rama (`git checkout -b feature/amazing-feature`)
3. Realiza tus cambios
4. Commitea tus cambios (`git commit -m 'Add some amazing feature'`)
5. Haz push a la rama (`git push origin feature/amazing-feature`)
6. Abre un Pull Request

## Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo `LICENSE` para más detalles.
