import 'package:summamovesapp/about.dart';
import 'package:summamovesapp/prestaties.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToPeoplePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PrestatiePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? Text('Home', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
            : null,
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Prestatie',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _selectedIndex == 0
            ? _buildHomeContent()
            : _selectedIndex == 1
            ? About()
            : PrestatiePage(),
      ),
    );
  }

  Widget _buildHomeContent() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
