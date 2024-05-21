import 'package:flutter/material.dart';

class HomePageModel with ChangeNotifier {
  /// State fields for stateful widgets in this page.
  final FocusNode unfocusNode = FocusNode();

  /// Inicialización del modelo, si es necesario.
  void initState() {
    // Agregar cualquier inicialización aquí si es necesario
  }

  @override
  void dispose() {
    // Asegúrate de limpiar cualquier controlador, como FocusNode.
    unfocusNode.dispose();
    super.dispose();
  }
}
