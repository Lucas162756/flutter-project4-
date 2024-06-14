import 'package:flutter/material.dart';

class OefeningIndexPage extends StatefulWidget {
  final void Function(bool status) setAutenticatieStatus;

  const OefeningIndexPage({super.key, required this.setAutenticatieStatus});

  @override
  State<OefeningIndexPage> createState() => _FunctieIndexPageState();
}

class _FunctieIndexPageState extends State<OefeningIndexPage> {
  late Future<List<Oefening>> _functies;

  @override
  void initState() {
    super.initState();
    _oefening = OefeningService().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oefening - Index'),
        actions: [_uitloggen()],
      ),
      drawer: DierenDrawer(),
      body: FutureBuilder<List<Oefening>>(
        future: _oefening,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
          return _oefeningIndex(snapshot.data!);
        },
      ),
    );
  }

  Widget _functieIndex(List<Oefening> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.settings),
          title: Text(data[index].naam),
        );
      },
    );
  }

  Widget _uitloggen() {
    return IconButton(
      onPressed: () {
        widget.setAutenticatieStatus(false);
      },
      icon: Icon(Icons.logout),
    );
  }
}