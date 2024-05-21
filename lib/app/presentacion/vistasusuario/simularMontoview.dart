import 'package:flutter/material.dart';

class SimularMontoView extends StatefulWidget {
  const SimularMontoView({super.key});

  @override
  State<SimularMontoView> createState() => _SimularMontoViewState();
}

class _SimularMontoViewState extends State<SimularMontoView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Vista de Simulación de Monto',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
