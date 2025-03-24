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
    // Parse inputs to appropriate types
    final x1 = double.tryParse(_x1Controller.text);
    final x2 = double.tryParse(_x2Controller.text);
    final x3 = double.tryParse(_x3Controller.text);
    final x4 = double.tryParse(_x4Controller.text);
    final x5 = double.tryParse(_x5Controller.text);
    final x6 = int.tryParse(_x6Controller.text);
    final x7 = double.tryParse(_x7Controller.text);
    final x8 = int.tryParse(_x8Controller.text);

    // Check for invalid inputs and collect errors
    List<String> errors = [];
    if (x1 == null) errors.add('X1');
    if (x2 == null) errors.add('X2');
    if (x3 == null) errors.add('X3');
    if (x4 == null) errors.add('X4');
    if (x5 == null) errors.add('X5');
    if (x6 == null) errors.add('X6');
    if (x7 == null) errors.add('X7');
    if (x8 == null) errors.add('X8');

    // Check for empty fields as well
    if (_x1Controller.text.isEmpty || _x2Controller.text.isEmpty ||
        _x3Controller.text.isEmpty || _x4Controller.text.isEmpty ||
        _x5Controller.text.isEmpty || _x6Controller.text.isEmpty ||
        _x7Controller.text.isEmpty || _x8Controller.text.isEmpty) {
      setState(() {
        _result = 'Error: All fields are required.';
      });
      return;
    }

    // If there are parsing errors, display them and stop
    if (errors.isNotEmpty) {
      setState(() {
        _result = 'Error: Invalid inputs for ${errors.join(', ')}. Please enter valid numbers.';
      });
      return;
    }

    // Create inputs map with parsed numerical values
    final inputs = {
      'X1': x1,
      'X2': x2,
      'X3': x3,
      'X4': x4,
      'X5': x5,
      'X6': x6,
      'X7': x7,
      'X8': x8,
    };

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
        backgroundColor: Colors.green[700], // Darker green for AppBar
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
            Center(
              child: ElevatedButton(
                onPressed: _makePrediction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0), // Larger padding
                ),
                child: const Text(
                  'Predict',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Display area for result or error
            Center(
              child: Text(
                _result,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _result.startsWith('Error') ? Colors.red : Colors.green[800], // Conditional coloring
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create consistent TextFields
  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
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