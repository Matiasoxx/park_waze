import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SimularMontoView extends StatefulWidget {
  const SimularMontoView({super.key});

  @override
  State<SimularMontoView> createState() => _SimularMontoViewState();
}

class _SimularMontoViewState extends State<SimularMontoView> {
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _additionalTimeController =
      TextEditingController();

  double? _initialAmount;
  double? _newAmount;

  final _dateFormat = DateFormat("HH:mm");

  String _selectedParkingType = 'Normal';
  final Map<String, double> _ratePerMinute = {
    'Normal': 20.0,
    'Especial': 23.0,
    'VIP': 25.0,
  };

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    _additionalTimeController.dispose();
    super.dispose();
  }

  void _simulateAmount() {
    final startTime = _parseTime(_startTimeController.text);
    final endTime = _parseTime(_endTimeController.text);
    final additionalTime = double.tryParse(_additionalTimeController.text) ?? 0;

    if (startTime == null || endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, introduce horas vÃ¡lidas.')),
      );
      return;
    }

    final differenceInMinutes =
        endTime.difference(startTime).inMinutes.toDouble();
    if (differenceInMinutes < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('La hora de fin debe ser mayor que la hora de inicio.')),
      );
      return;
    }

    final ratePerMinute = _ratePerMinute[_selectedParkingType]!;
    final initialAmount = differenceInMinutes * ratePerMinute;
    final newAmount = additionalTime > 0
        ? (differenceInMinutes + additionalTime) * ratePerMinute
        : null;

    setState(() {
      _initialAmount = initialAmount;
      _newAmount = newAmount;
    });
  }

  DateTime? _parseTime(String time) {
    try {
      return _dateFormat.parse(time);
    } catch (e) {
      return null;
    }
  }

  void _formatTime(TextEditingController controller, String value) {
    if (value.length == 2 && !value.contains(':')) {
      final formatted = '$value:';
      controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(
            child: Text('Tarifa', style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tipos de estacionamiento',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: _selectedParkingType,
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                icon: const Icon(Icons.arrow_downward, color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedParkingType = newValue!;
                  });
                },
                items: _ratePerMinute.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _startTimeController,
                style: const TextStyle(color: Colors.white),
                maxLength: 5,
                decoration: const InputDecoration(
                  labelText: 'Hora de inicio (HH:mm)',
                  labelStyle: TextStyle(color: Colors.white),
                  counterText: "",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                cursorColor: Colors.white,
                keyboardType: TextInputType.number,
                onChanged: (value) => _formatTime(_startTimeController, value),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _endTimeController,
                style: const TextStyle(color: Colors.white),
                maxLength: 5,
                decoration: const InputDecoration(
                  labelText: 'Hora de fin (HH:mm)',
                  labelStyle: TextStyle(color: Colors.white),
                  counterText: "",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                cursorColor: Colors.white,
                keyboardType: TextInputType.number,
                onChanged: (value) => _formatTime(_endTimeController, value),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _additionalTimeController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Tiempo adicional (minutos)',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                cursorColor: Colors.white,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _simulateAmount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('Calcular Monto'),
                ),
              ),
              if (_initialAmount != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('Monto inicial: \$${_initialAmount!.toInt()}',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                ),
              if (_newAmount != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                      'Monto con tiempo adicional: \$${_newAmount!.toInt()}',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
