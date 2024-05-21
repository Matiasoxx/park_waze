import 'package:flutter/material.dart';
import 'package:park_waze/app/presentacion/vista_admin/aScaffold.dart';
import 'package:park_waze/app/presentacion/vista_admin/estadisticas.dart';
import 'package:park_waze/app/presentacion/vista_admin/profileAdmin.dart';

class HomeViewAdmin extends StatefulWidget {
  final dynamic userData;
  const HomeViewAdmin({super.key, required this.userData});

  @override
  _HomeViewAdminState createState() => _HomeViewAdminState();
}

class _HomeViewAdminState extends State<HomeViewAdmin> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('Inicio')),
    const EstadisticasView(),
    const ProfileAdminView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}


