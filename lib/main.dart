import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConverterScreen(),
    );
  }
}

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _valueController = TextEditingController();
  String? _fromUnit;
  String? _toUnit;
  String _result = '';

  final List<String> _units = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles'
  ];

  void _convert() {
    double? value = double.tryParse(_valueController.text);
    if (value == null || _fromUnit == null || _toUnit == null) {
      setState(() {
        _result = 'Please enter a valid value and select units.';
      });
      return;
    }

    // Simple conversion logic (add your own logic for more units)
    double convertedValue;
    if (_fromUnit == 'meters' && _toUnit == 'kilometers') {
      convertedValue = value / 1000;
    } else if (_fromUnit == 'kilometers' && _toUnit == 'meters') {
      convertedValue = value * 1000;
    } else if (_fromUnit == 'grams' && _toUnit == 'kilograms') {
      convertedValue = value / 1000;
    } else if (_fromUnit == 'kilograms' && _toUnit == 'grams') {
      convertedValue = value * 1000;
    } else {
      convertedValue = value; // No conversion applied
    }

    setState(() {
      _result = 'Result: $convertedValue $_toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Measures Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter value',
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('From Unit'),
              value: _fromUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _fromUnit = newValue;
                });
              },
              items: _units.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('To Unit'),
              value: _toUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _toUnit = newValue;
                });
              },
              items: _units.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
