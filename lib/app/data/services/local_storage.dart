import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal();

  late Box _userBox;

  Future<void> init() async {
    //Inicializamos Hive
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    // Abrimos la caja (Box) para almacenar datos de usuario
    _userBox = await Hive.openBox('userBox');
  }

  // Limpiar datos
  Future<void> clear() async {
    await _userBox.clear();
  }

  //Guardar datos del usuario
  Future<void> saveUserData(String email, String password) async {
    await _userBox.put('email', email);
    await _userBox.put('password', password);
  }

  //obtener datos
  Future<dynamic> getUserData(String email) async {
    final String password =
        _userBox.get('password', defaultValue: '') as String;

    return {
      'email': email,
      'password': password,
    };
  }

  String getEmail() {
    return _userBox.get('email', defaultValue: '') as String;
  }

  String getPassword() {
    return _userBox.get('password', defaultValue: '') as String;
  }

  Future<void> setIsSignedIn(bool isSignedIn) async {
    await _userBox.get('is_signedin', defaultValue: false) as bool;
  }

  bool getIsSignedIn() {
    return _userBox.get('is_signedin', defaultValue: false) as bool;
  }

  Future<void> deleteIsSignedIn() async {
    // Eliminar la clave 'is_signedin' de la caja
    await _userBox.delete('is_signedin');
  }

  Future<void> setIsLoggedIn(bool isLoggedIn) async {
    // Guardar el valor de 'isLoggedIn' en la caja
    await _userBox.put('is LoggedIn', isLoggedIn);
  }

  bool getIsLoggedIn() {
    // Obtener el valor de 'isLoggedIn' de la caja
    return _userBox.get('isLoggedIn', defaultValue: false) as bool;
  }

  Future<bool> getIsFirstTime() async {
    final bool isFirstTime =
        _userBox.get('isFirstTime', defaultValue: true) as bool;
    if (isFirstTime) {
      await _userBox.put('isFirstTime', false);
      return true;
    }
    return false;
  }

  Future<void> savePageIndex(int index) async {
    await _userBox.put('pageIndex', index);
  }

  int getPageIndex() {
    return _userBox.get('pageIndex', defaultValue: 0) as int;
  }
}
