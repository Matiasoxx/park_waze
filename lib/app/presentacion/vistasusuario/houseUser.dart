import 'package:flutter/material.dart';

class HouseUserView extends StatefulWidget {
  const HouseUserView({super.key});

  @override
  State<HouseUserView> createState() => _HouseUserViewState();
}

class _HouseUserViewState extends State<HouseUserView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Vista Principal',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
