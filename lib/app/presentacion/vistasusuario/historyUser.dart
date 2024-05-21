import 'package:flutter/material.dart';

class HistoryUserView extends StatefulWidget {
  const HistoryUserView({super.key});

  @override
  State<HistoryUserView> createState() => _HistoryUserViewState();
}

class _HistoryUserViewState extends State<HistoryUserView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Vista de Historial',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
