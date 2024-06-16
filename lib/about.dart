import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('About'),

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Mijn naam is Lucas de Raaij',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Doe de opleiding, Software  development',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Gebruikte book API',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Hoop dat je een leuke titel kunt vinden',
                style: TextStyle(fontSize: 18),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
