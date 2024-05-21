import 'package:flutter/material.dart';
import 'package:park_waze/generated/l10n.dart';

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
        automaticallyImplyLeading: false,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onNavTap,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        elevation: 10,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).uvInicio,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.attach_money),
            label: S.of(context).uvMont,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: S.of(context).uvHistory,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_box),
            label: S.of(context).uvProfile,
          ),
        ],
      ),
    );
  }
}
