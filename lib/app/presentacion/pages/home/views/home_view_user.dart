import 'package:flutter/material.dart';
import 'package:park_waze/app/presentacion/vistasusuario/bScaffold.dart';
import 'package:park_waze/app/presentacion/vistasusuario/historyUser.dart';
import 'package:park_waze/app/presentacion/vistasusuario/profileUser.dart';
import 'package:park_waze/app/presentacion/vistasusuario/simularMontoview.dart';

class HomeViewUser extends StatefulWidget {
  final dynamic userData;
  const HomeViewUser({super.key, required this.userData});

  @override
  _HomeViewUserState createState() => _HomeViewUserState();
}

class _HomeViewUserState extends State<HomeViewUser> {
  int _paginaActu = 0;

  final List<Widget> _paginasUser = [
    const ProfileUser(),
    const SimularMontoView(),
    const HistoryUserView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _paginaActu = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: _paginaActu,
      userData: widget.userData,
      onNavTap: _onItemTapped,
      pages: _paginasUser,
    );
  }
}
