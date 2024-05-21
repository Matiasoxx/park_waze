import 'package:flutter/material.dart';
import 'package:park_waze/app/presentacion/vistasusuario/bScaffold.dart';
import 'package:park_waze/app/presentacion/vistasusuario/historyUser.dart';
import 'package:park_waze/app/presentacion/vistasusuario/houseUser.dart';
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
  late List<Widget> _paginasUser;

  @override
  void initState() {
    super.initState();
    _paginasUser = [
      const HouseUserView(),
      const SimularMontoView(),
      const HistoryUserView(),
      ProfileUser(userData: widget.userData),
    ];
  }

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
