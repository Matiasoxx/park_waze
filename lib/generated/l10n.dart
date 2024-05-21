// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Bienvenido a Park Waze`
  String get tWelcome {
    return Intl.message(
      'Bienvenido a Park Waze',
      name: 'tWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Antes de empezar. Indicanos tú idioma de preferencia`
  String get languagePrompt {
    return Intl.message(
      'Antes de empezar. Indicanos tú idioma de preferencia',
      name: 'languagePrompt',
      desc: '',
      args: [],
    );
  }

  /// `Inglés`
  String get english {
    return Intl.message(
      'Inglés',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Español`
  String get spanish {
    return Intl.message(
      'Español',
      name: 'spanish',
      desc: '',
      args: [],
    );
  }

  /// `¿Ya tienes una cuenta?`
  String get accountPrompt {
    return Intl.message(
      '¿Ya tienes una cuenta?',
      name: 'accountPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Registrarse`
  String get bRegister {
    return Intl.message(
      'Registrarse',
      name: 'bRegister',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar sesión`
  String get bLogin {
    return Intl.message(
      'Iniciar sesión',
      name: 'bLogin',
      desc: '',
      args: [],
    );
  }

  /// `Verifica tú correo electronico`
  String get taVerifyEmail {
    return Intl.message(
      'Verifica tú correo electronico',
      name: 'taVerifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Por favor verifica tu correo electrónico para continuar.`
  String get aVerifyEmailBody {
    return Intl.message(
      'Por favor verifica tu correo electrónico para continuar.',
      name: 'aVerifyEmailBody',
      desc: '',
      args: [],
    );
  }

  /// `Aceptar`
  String get bAceptarButton {
    return Intl.message(
      'Aceptar',
      name: 'bAceptarButton',
      desc: '',
      args: [],
    );
  }

  /// `Correo Electrónico`
  String get lCorreo {
    return Intl.message(
      'Correo Electrónico',
      name: 'lCorreo',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get lContra {
    return Intl.message(
      'Contraseña',
      name: 'lContra',
      desc: '',
      args: [],
    );
  }

  /// `Por favor ingresa un correo electrónico valido.`
  String get validMail {
    return Intl.message(
      'Por favor ingresa un correo electrónico valido.',
      name: 'validMail',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña muy corta. Asegurate que estas colocando tú contraseña de manera correcta.`
  String get validPass {
    return Intl.message(
      'Contraseña muy corta. Asegurate que estas colocando tú contraseña de manera correcta.',
      name: 'validPass',
      desc: '',
      args: [],
    );
  }

  /// `Ingresar`
  String get ingresar {
    return Intl.message(
      'Ingresar',
      name: 'ingresar',
      desc: '',
      args: [],
    );
  }

  /// `¿Olvidaste la contraseña?`
  String get forgotPassw {
    return Intl.message(
      '¿Olvidaste la contraseña?',
      name: 'forgotPassw',
      desc: '',
      args: [],
    );
  }

  /// `Park Waze`
  String get tituloProyecto {
    return Intl.message(
      'Park Waze',
      name: 'tituloProyecto',
      desc: '',
      args: [],
    );
  }

  /// `Ingresa tu correo electrónico y te enviaremos un correo para que recuperes tu contraseña.`
  String get forgotPasswTit {
    return Intl.message(
      'Ingresa tu correo electrónico y te enviaremos un correo para que recuperes tu contraseña.',
      name: 'forgotPasswTit',
      desc: '',
      args: [],
    );
  }

  /// `Enviar`
  String get envi {
    return Intl.message(
      'Enviar',
      name: 'envi',
      desc: '',
      args: [],
    );
  }

  /// `Hemos enviado el correo electrónico, revisa tú bandeja de entrada`
  String get dialogAlertSendEmail {
    return Intl.message(
      'Hemos enviado el correo electrónico, revisa tú bandeja de entrada',
      name: 'dialogAlertSendEmail',
      desc: '',
      args: [],
    );
  }

  /// `El correo ingresado no existe en la base de datos. Intentalo otra vez.`
  String get dialogAlertSendEmailFailed {
    return Intl.message(
      'El correo ingresado no existe en la base de datos. Intentalo otra vez.',
      name: 'dialogAlertSendEmailFailed',
      desc: '',
      args: [],
    );
  }

  /// `Ha ocurrido un error. Intentalo más tarde.`
  String get defaultErrorMessage {
    return Intl.message(
      'Ha ocurrido un error. Intentalo más tarde.',
      name: 'defaultErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Registrarse`
  String get titleRegister {
    return Intl.message(
      'Registrarse',
      name: 'titleRegister',
      desc: '',
      args: [],
    );
  }

  /// `No has seleccionado una imagen`
  String get noImagen {
    return Intl.message(
      'No has seleccionado una imagen',
      name: 'noImagen',
      desc: '',
      args: [],
    );
  }

  /// `Selecciona una imagen`
  String get imagenButton {
    return Intl.message(
      'Selecciona una imagen',
      name: 'imagenButton',
      desc: '',
      args: [],
    );
  }

  /// `Nombre Completo`
  String get labelName {
    return Intl.message(
      'Nombre Completo',
      name: 'labelName',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de Nacimiento`
  String get lFechaNacimiento {
    return Intl.message(
      'Fecha de Nacimiento',
      name: 'lFechaNacimiento',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, ingresa tu fecha de nacimiento.`
  String get lValidDate {
    return Intl.message(
      'Por favor, ingresa tu fecha de nacimiento.',
      name: 'lValidDate',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar Contraseña`
  String get lCContra {
    return Intl.message(
      'Confirmar Contraseña',
      name: 'lCContra',
      desc: '',
      args: [],
    );
  }

  /// `Marca del Vehículo`
  String get lMarca {
    return Intl.message(
      'Marca del Vehículo',
      name: 'lMarca',
      desc: '',
      args: [],
    );
  }

  /// `Por favor seleccione una marca`
  String get lValidMarca {
    return Intl.message(
      'Por favor seleccione una marca',
      name: 'lValidMarca',
      desc: '',
      args: [],
    );
  }

  /// `Modelo del Vehículo`
  String get lModelo {
    return Intl.message(
      'Modelo del Vehículo',
      name: 'lModelo',
      desc: '',
      args: [],
    );
  }

  /// `Por favor selecciona un modelo`
  String get lValidModelo {
    return Intl.message(
      'Por favor selecciona un modelo',
      name: 'lValidModelo',
      desc: '',
      args: [],
    );
  }

  /// `Patente del Vehículo`
  String get lPatente {
    return Intl.message(
      'Patente del Vehículo',
      name: 'lPatente',
      desc: '',
      args: [],
    );
  }

  /// `El nombre no puede estar vacío.`
  String get nameNotEmpty {
    return Intl.message(
      'El nombre no puede estar vacío.',
      name: 'nameNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `El nombre solo puede contener letras y espacios.`
  String get nameRequired {
    return Intl.message(
      'El nombre solo puede contener letras y espacios.',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Correo invalido`
  String get correoInvalid {
    return Intl.message(
      'Correo invalido',
      name: 'correoInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, ingrese una contraseña.`
  String get passEmpty {
    return Intl.message(
      'Por favor, ingrese una contraseña.',
      name: 'passEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña invalida.`
  String get invalidPass {
    return Intl.message(
      'Contraseña invalida.',
      name: 'invalidPass',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña debe tener más de 8 caracteres.`
  String get passRequired {
    return Intl.message(
      'La contraseña debe tener más de 8 caracteres.',
      name: 'passRequired',
      desc: '',
      args: [],
    );
  }

  /// `Las contraseñas no coinciden.`
  String get passNotSimilar {
    return Intl.message(
      'Las contraseñas no coinciden.',
      name: 'passNotSimilar',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, ingrese la patente del vehículo.`
  String get patentEmpty {
    return Intl.message(
      'Por favor, ingrese la patente del vehículo.',
      name: 'patentEmpty',
      desc: '',
      args: [],
    );
  }

  /// `La patente debe contener 4 letras sin vocales y 2 números al final.`
  String get patentRequired {
    return Intl.message(
      'La patente debe contener 4 letras sin vocales y 2 números al final.',
      name: 'patentRequired',
      desc: '',
      args: [],
    );
  }

  /// `Debe seleccionar una marca y modelo del vehículo.`
  String get marcAndModelRequired {
    return Intl.message(
      'Debe seleccionar una marca y modelo del vehículo.',
      name: 'marcAndModelRequired',
      desc: '',
      args: [],
    );
  }

  /// `El correo ingresado está vinculado a otra cuenta.`
  String get correoExist {
    return Intl.message(
      'El correo ingresado está vinculado a otra cuenta.',
      name: 'correoExist',
      desc: '',
      args: [],
    );
  }

  /// `La patente que ingresó ya se encuentra en uso.`
  String get patenteExist {
    return Intl.message(
      'La patente que ingresó ya se encuentra en uso.',
      name: 'patenteExist',
      desc: '',
      args: [],
    );
  }

  /// `Revisa tú correo elecetronico para verificar la cuenta.`
  String get reviewYourEmail {
    return Intl.message(
      'Revisa tú correo elecetronico para verificar la cuenta.',
      name: 'reviewYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Inicio`
  String get uvInicio {
    return Intl.message(
      'Inicio',
      name: 'uvInicio',
      desc: '',
      args: [],
    );
  }

  /// `Monto a pagar`
  String get uvMont {
    return Intl.message(
      'Monto a pagar',
      name: 'uvMont',
      desc: '',
      args: [],
    );
  }

  /// `Historial`
  String get uvHistory {
    return Intl.message(
      'Historial',
      name: 'uvHistory',
      desc: '',
      args: [],
    );
  }

  /// `Perfil`
  String get uvProfile {
    return Intl.message(
      'Perfil',
      name: 'uvProfile',
      desc: '',
      args: [],
    );
  }

  /// `Editar Perfil`
  String get editProf {
    return Intl.message(
      'Editar Perfil',
      name: 'editProf',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar idioma`
  String get chLengu {
    return Intl.message(
      'Cambiar idioma',
      name: 'chLengu',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar Sesión`
  String get logout {
    return Intl.message(
      'Cerrar Sesión',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar cuenta`
  String get deletAcc {
    return Intl.message(
      'Eliminar cuenta',
      name: 'deletAcc',
      desc: '',
      args: [],
    );
  }

  /// `Nombre Completo`
  String get fullNam {
    return Intl.message(
      'Nombre Completo',
      name: 'fullNam',
      desc: '',
      args: [],
    );
  }

  /// `Edad`
  String get edad {
    return Intl.message(
      'Edad',
      name: 'edad',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
