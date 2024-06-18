import 'dart:ui'; // Import dart:ui package for CircleAvatar widget
import 'package:summamovesapp/about.dart';
import 'package:summamovesapp/detail.dart';
import 'package:summamovesapp/service.dart';
import 'package:flutter/material.dart';

class OefeningenPage extends StatefulWidget {
  @override
  _OefeningenPageState createState() => _OefeningenPageState();
}

class _OefeningenPageState extends State<OefeningenPage> {
  late Future<List<Oefeningen>> futureOefeningen;
  late TextEditingController searchController;
  late List<Oefeningen> filteredOefeningen;
  late List<Oefeningen> allOefeningen; // New variable to store all oefeningen
  late OefeningenService oefeningenService;

  @override
  void initState() {
    super.initState();
    oefeningenService = OefeningenService(); // Instantiate OefeningenService
    futureOefeningen = oefeningenService.getOefeningen();
    searchController = TextEditingController();
    filteredOefeningen = [];
    allOefeningen = []; // Initialize allOefeningen list
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Oefeningen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.jpg"), //
            fit: BoxFit.cover,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            var oefeningen = await oefeningenService.getOefeningen();
            setState(() {
              futureOefeningen = Future.value(oefeningen);
            });
          },
          child: FutureBuilder<List<Oefeningen>>(
            future: futureOefeningen,
            builder: (BuildContext context, AsyncSnapshot<List<Oefeningen>> snapshot) {
              if (snapshot.hasData) {
                allOefeningen = snapshot.data!;
                return Column(
                  children: [
                    _buildSearchBar(),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(16),
                        itemCount: filteredOefeningen.isEmpty ? allOefeningen.length : filteredOefeningen.length,
                        itemBuilder: (context, index) {
                          Oefeningen oefeningen = filteredOefeningen.isEmpty ? allOefeningen[index] : filteredOefeningen[index];
                          return InkWell(
                            onTap: () => openPage(context, oefeningen),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[200]?.withOpacity(0.8), // Adjust opacity of background color
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 12), // Space between image and name
                                  Text(
                                    oefeningen.info.beschrijving,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.chevron_right_outlined),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 16),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Er is een fout : ${snapshot.error}'));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  void openPage(BuildContext context, Oefeningen oefeningen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(oefeningen: oefeningen)),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search oefeningen...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onChanged: (value) {
          setState(() {
            filteredOefeningen = oefeningenService.filterOefeningenByFirstLetter(value, allOefeningen);
          });
        },
      ),
    );
  }
}
