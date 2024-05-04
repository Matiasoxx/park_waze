mixin SignInMixin {
  String? emailValidator(String? text) {
    text = text ?? '';
    text.replaceAll(" ", "");
    const isValidEmail = '@gmail.com';
    if (text.endsWith(isValidEmail)) {
      return null;
    }
    return 'Correo invalido';
  }

  String? passwordValidator(String? password, String? confirmPassword) {
    if (password == null || password.isEmpty) {
      return 'Por favor, ingrese una contraseña.';
    }
    if (!RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$")
        .hasMatch(password)) {
      return 'Contraseña invalida';
    }
    if (password.length <= 8) {
      return 'La contraseña debe tener más de 8 caracteres';
    }
    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  List<String> getModelosPorMarca(String marca) {
    switch (marca) {
      case 'Ford':
        return ['Mustang', 'Fiesta', 'Focus'];
      case 'Chevrolet':
        return ['Camaro', 'Malibu', 'Silverado'];
      case 'Toyota':
        return ['Corolla', 'Camry', 'Prius'];
      case 'Honda':
        return ['Civic', 'Accord', 'CR-V'];
      case 'BMW':
        return ['320', 'X5', 'M4'];
      default:
        return [];
    }
  }

  String? patenteValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese la patente del vehículo.';
    }

    // Regex para validar que contiene 4 letras sin vocales al inicio y 2 números al final
    RegExp patenteRegex = RegExp(r'^[^aeiouAEIOU]{4}\d{2}$');

    if (!patenteRegex.hasMatch(value)) {
      return 'La patente debe contener 4 letras sin vocales y 2 números al final.';
    }

    return null;
  }
}
