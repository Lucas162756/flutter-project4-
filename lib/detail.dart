import 'package:summamovesapp/service.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Prestatie prestatie;

  const DetailPage({Key? key, required this.prestatie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gebruikers ID: ${prestatie.info.gebruikers_id}'),
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
            Text('Oefeningen ID: ${prestatie.info.Oefeningen_id}'),
            Text('Score: ${prestatie.info.score}'),
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
