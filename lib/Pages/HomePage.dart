import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('lib/Assets/Animals.jpg',),
            fit: BoxFit.cover
        )),
        child: Center(child:Text('Summa-Move', style: TextStyle(color: Colors.purple, fontSize: 60, fontWeight: FontWeight.bold)))
    );
  }
}