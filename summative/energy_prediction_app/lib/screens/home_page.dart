import 'package:flutter/material.dart';
import 'prediction_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Energy Efficiency Prediction'),
        backgroundColor: Colors.green[700], // Dark green to match PredictionPage
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Energy Prediction App',
              style: TextStyle(
                fontSize: 24, // Larger font for prominence
                fontWeight: FontWeight.bold, // Bold for emphasis
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40), // Increased spacing for balance
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PredictionPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen[300], // Light green like PredictionPage
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 16.0,
                ), // Larger padding for a prominent button
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Go to Prediction',
                    style: TextStyle(
                      fontSize: 18, // Consistent with PredictionPage button
                      color: Colors.white, // White text for contrast
                    ),
                  ),
                  SizedBox(width: 8), // Space between text and icon
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white, // White icon to match text
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}