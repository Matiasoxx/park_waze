import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';

mixin SignInMixin {
  String? nombreCompletoValidator(String? text, BuildContext context) {
    RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
    if (text == null || text.isEmpty) {
      return S.of(context).nameNotEmpty;
    } else if (!regex.hasMatch(text)) {
      return S.of(context).nameRequired;
    }
    return null;
  }

  String? emailValidator(String? text, BuildContext context) {
    text = text ?? '';
    text.replaceAll(" ", "");
    const isValidEmail = '@gmail.com';
    if (text.endsWith(isValidEmail)) {
      return null;
    }
    return S.of(context).correoInvalid;
  }

  String? passwordValidator(
      String? password, String? confirmPassword, BuildContext context) {
    if (password == null || password.isEmpty) {
      return S.of(context).passEmpty;
    }
    if (!RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$")
        .hasMatch(password)) {
      return S.of(context).invalidPass;
    }
    if (password.length <= 8) {
      return S.of(context).passRequired;
    }
    if (password != confirmPassword) {
      return S.of(context).passNotSimilar;
    }
    return null;
  }

  List<String> getModelosPorMarca(String marca) {
    switch (marca) {
      case 'Ford':
        return [
          'Nueva Escape Híbirida',
          'Nueva Maverick Híbrida',
          'F-150 Híbrida',
          'Nueva Territory',
          'Nueva Escape',
          'Edge',
          'Edge ST',
          'Bronco Sport',
          'Explorer',
          'Explorer ST',
          'Expedition',
          'Maverick',
          'Nueva Ranger',
          'Nueva Ranger Raptor',
          'F-150',
          'F-15 Raptor',
          'Transit Custom',
          'Transit Chasis',
          'Transit Furgón',
          'Transit Bus',
          'Nuevo Mustang'
        ];
      case 'Chevrolet':
        return [
          'Sail',
          'Sail Hatchback',
          'Onix Sedán',
          'Onix Turbo',
          'Onix Turbo RS',
          'Groove',
          'Spin',
          'Tracker',
          'Captiva',
          'Traverse',
          'Blazer',
          'Tahoe',
          'Suburban',
          'N400',
          'Montan',
          'Silverado',
          'Bolt EUV',
          'NKR 512',
          'NKR 612',
          'NPR 715',
          'NPR 816',
          'NPR 816 AMT',
          'NPR 816 DC',
          'NQR 919',
          'FRR 1119',
          'NUEVO FRR 1119 AMT',
          'NPS 816 4X4',
          'FTR 1524',
          'FVR 1724',
          'NUEVO FTR 1524 AMT',
          'FVR 1826',
          'NUEVO FVR 1724 AT'
        ];
      case 'Toyota':
        return [
          'Corolla',
          'Yaris',
          'Prius',
          'Yaris Hatchback',
          'GR Yaris',
          'Raize',
          'Corolla Cross',
          'RAV4',
          'Fortuner',
          '4Runner',
          'Land Cruiser Prado',
          'Yaris Cross',
          'Hilux',
          'Land Cruiser',
          'Camry',
          'C-HR',
          'Tacoma',
          'Tundra',
          'Sequoia',
          'Avalon',
          'Sienna',
          'Highlander',
          'Venza',
          'Mirai'
        ];
      case 'Honda':
        return [
          'Civic',
          'Accord',
          'CR-V',
          'Fit',
          'HR-V',
          'Pilot',
          'Odyssey',
          'Ridgeline',
          'Passport',
          'Insight',
          'Clarity',
          'Jazz',
          'City',
          'Amaze',
          'BR-V',
          'Mobilio'
        ];
      case 'BMW':
        return [
          '320i',
          '330i',
          'M3',
          'M4',
          'M5',
          'M8',
          'X1',
          'X2',
          'X3',
          'X4',
          'X5',
          'X6',
          'X7',
          'i3',
          'i4',
          'i8',
          'Z4',
          '2 Series',
          '3 Series',
          '4 Series',
          '5 Series',
          '6 Series',
          '7 Series',
          '8 Series'
        ];
      case 'Nissan':
        return [
          'Versa',
          'Sentra',
          'Altima',
          'Maxima',
          'Leaf',
          '370Z',
          'GT-R',
          'Kicks',
          'Rogue',
          'Murano',
          'Pathfinder',
          'Armada',
          'Frontier',
          'Titan',
          'NV200',
          'NV Cargo',
          'NV Passenger'
        ];
      case 'Volkswagen':
        return [
          'Polo',
          'Golf',
          'Tiguan',
          'Passat',
          'Arteon',
          'Touareg',
          'T-Cross',
          'Atlas',
          'Jetta',
          'Beetle',
          'ID.4',
          'Golf GTI',
          'Golf R'
        ];
      case 'Mercedes-Benz':
        return [
          'A-Class',
          'C-Class',
          'E-Class',
          'S-Class',
          'GLA',
          'GLB',
          'GLC',
          'GLE',
          'GLS',
          'G-Class',
          'CLA',
          'CLS',
          'SL',
          'SLC',
          'AMG GT',
          'EQC'
        ];
      case 'Audi':
        return [
          'A3',
          'A4',
          'A5',
          'A6',
          'A7',
          'A8',
          'Q3',
          'Q5',
          'Q7',
          'Q8',
          'TT',
          'R8',
          'e-tron',
          'e-tron GT',
          'RS3',
          'RS4',
          'RS5',
          'RS6',
          'RS7',
          'RS Q8'
        ];
      case 'Hyundai':
        return [
          'Accent',
          'Elantra',
          'Sonata',
          'Veloster',
          'Ioniq',
          'Kona',
          'Tucson',
          'Santa Fe',
          'Palisade',
          'Nexo'
        ];
      default:
        return [];
    }
  }

  String? patenteValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return S.of(context).patentEmpty;
    }

    // Regex para validar que contiene 4 letras sin vocales al inicio y 2 números al final
    RegExp patenteRegex = RegExp(r'^[^aeiouAEIOU]{4}\d{2}$');

    if (!patenteRegex.hasMatch(value)) {
      return S.of(context).patentRequired;
    }

    return null;
  }
}
