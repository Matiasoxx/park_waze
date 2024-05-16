import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final int currentIndex;
  final dynamic userData;
  final ValueChanged<int> onNavTap;
  final List<Widget> pages;

  const BaseScaffold({
    super.key,
    required this.currentIndex,
    required this.userData,
    required this.onNavTap,
    required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Park Waze'),
      ),
      body: Center(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onNavTap,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'Monto a pagar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Historial'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Perfil'),
        ],
      ),
    );
  }
}
