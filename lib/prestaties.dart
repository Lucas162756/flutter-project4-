import 'dart:ui'; // Import dart:ui package for CircleAvatar widget
import 'package:summamovesapp/about.dart';
import 'package:summamovesapp/detail.dart';
import 'package:summamovesapp/service.dart';
import 'package:flutter/material.dart';

class PrestatiePage extends StatefulWidget {
  @override
  _PrestatiePageState createState() => _PrestatiePageState();
}

class _PrestatiePageState extends State<PrestatiePage> {
  late Future<List<Prestatie>> futurePrestaties;
  late TextEditingController searchController;
  late List<Prestatie> filteredPrestaties;
  late List<Prestatie> allPrestaties; // New variable to store all prestaties

  @override
  void initState() {
    super.initState();
    futurePrestaties = PrestatieService().getPrestaties();
    searchController = TextEditingController();
    filteredPrestaties = [];
    allPrestaties = []; // Initialize allPrestaties list
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
          'Prestaties',
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
            var prestaties = await PrestatieService().getPrestaties();
            setState(() {
              futurePrestaties = Future.value(prestaties);
            });
          },
          child: FutureBuilder<List<Prestatie>>(
            future: futurePrestaties,
            builder: (BuildContext context, AsyncSnapshot<List<Prestatie>> snapshot) {
              if (snapshot.hasData) {
                allPrestaties = snapshot.data!;
                return Column(
                  children: [
                    _buildSearchBar(),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(16),
                        itemCount: filteredPrestaties.isEmpty ? allPrestaties.length : filteredPrestaties.length,
                        itemBuilder: (context, index) {
                          Prestatie prestatie = filteredPrestaties.isEmpty ? allPrestaties[index] : filteredPrestaties[index];
                          return InkWell(
                            onTap: () => openPage(context, prestatie),
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
                                    prestatie.info.gebruikers_id.toString(),
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

  void openPage(BuildContext context, Prestatie prestatie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(prestatie: prestatie)),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search prestaties...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onChanged: (value) {
          setState(() {
            filteredPrestaties = service().filterPrestatiesByFirstLetter(value, allPrestaties);
          });
        },
      ),
    );
  }
}
