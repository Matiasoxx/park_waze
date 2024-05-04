import 'package:flutter/material.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view_admin.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view_user.dart';

class HomeView extends StatefulWidget {
  final dynamic userData;
  final String role;

  const HomeView({super.key, required this.userData, required this.role});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    // Decide qué vista mostrar según el rol
    Widget contentView;
    if (widget.role == 'user') {
      contentView = HomeViewUser(userData: widget.userData);
    } else if (widget.role == 'admin') {
      contentView = HomeViewAdmin(userData: widget.userData);
    } else {
      contentView = Container();
    }

    return Scaffold(
      body: Center(
        child: contentView,
      ),
    );
  }
}
