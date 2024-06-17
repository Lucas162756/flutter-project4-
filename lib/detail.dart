import 'package:summamovesapp/service.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Oefeningen oefeningen;

  const DetailPage({Key? key, required this.oefeningen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beschrijving: ${oefeningen.info.beschrijving}'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            const SizedBox(
              height: 80,
            ),
            Text('Naam: ${oefeningen.info.naam}'),
            Text('foto: ${oefeningen.info.foto}'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to previous page
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
