import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  // Text controllers for the 8 input variables
  final _x1Controller = TextEditingController();
  final _x2Controller = TextEditingController();
  final _x3Controller = TextEditingController();
  final _x4Controller = TextEditingController();
  final _x5Controller = TextEditingController();
  final _x6Controller = TextEditingController();
  final _x7Controller = TextEditingController();
  final _x8Controller = TextEditingController();

  // Variable to store the prediction result or error message
  String _result = '';

  // API endpoint URL
  final String _apiUrl = 'https://energy-prediction-00ed.onrender.com/predict';

  // Function to make the API call
  Future<void> _makePrediction() async {
    // Collect inputs into a map
    final inputs = {
      'X1': _x1Controller.text,
      'X2': _x2Controller.text,
      'X3': _x3Controller.text,
      'X4': _x4Controller.text,
      'X5': _x5Controller.text,
      'X6': _x6Controller.text,
      'X7': _x7Controller.text,
      'X8': _x8Controller.text,
    };

    // Basic validation: Check for empty fields
    if (inputs.values.any((value) => value.isEmpty)) {
      setState(() {
        _result = 'Error: All fields are required.';
      });
      return;
    }

    // Send POST request to the API
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(inputs),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _result = 'Predicted Heating Load: ${data['heating_load']}';
        });
      } else {
        setState(() {
          _result = 'Error: ${response.statusCode} - ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: Failed to connect to the API.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input fields for the 8 variables
            _buildTextField(_x1Controller, 'Relative Compactness (X1)', '0.62 to 0.98'),
            _buildTextField(_x2Controller, 'Surface Area (X2)', '514.5 to 808.5'),
            _buildTextField(_x3Controller, 'Wall Area (X3)', '245.0 to 416.5'),
            _buildTextField(_x4Controller, 'Roof Area (X4)', '110.25 to 220.5'),
            _buildTextField(_x5Controller, 'Overall Height (X5)', '3.5 to 7.0'),
            _buildTextField(_x6Controller, 'Orientation (X6)', '2, 3, 4, or 5'),
            _buildTextField(_x7Controller, 'Glazing Area (X7)', '0.0 to 0.4'),
            _buildTextField(_x8Controller, 'Glazing Area Distribution (X8)', '0 to 5'),
            const SizedBox(height: 20),
            // Predict button
            ElevatedButton(
              onPressed: _makePrediction,
              child: const Text('Predict'),
            ),
            const SizedBox(height: 20),
            // Display area for result or error
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create consistent TextFields
  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controllers
    _x1Controller.dispose();
    _x2Controller.dispose();
    _x3Controller.dispose();
    _x4Controller.dispose();
    _x5Controller.dispose();
    _x6Controller.dispose();
    _x7Controller.dispose();
    _x8Controller.dispose();
    super.dispose();
  }
}