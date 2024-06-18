import 'package:http/http.dart' as http;
import 'dart:convert';

class Info {
  final String beschrijving;
  final String naam;
  final int foto;

  const Info({
    required this.beschrijving,
    required this.naam,
    required this.foto,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      beschrijving: json['beschrijving'] ?? '', // Ensure 'beschrijving' field is present
      naam: json['naam'] ?? '', // Ensure 'naam' field is present
      foto: json['foto'] ?? 0, // Ensure 'score' field is present
    );
  }
}

class Oefeningen {
  final String subjects;
  final Info info;

  const Oefeningen({
    required this.subjects,
    required this.info,
  });

  factory Oefeningen.fromJson(Map<String, dynamic> json) {
    // Assuming subjects is a List of strings, and joining them as a single string
    String subjects = json['subjects'] != null ? (json['subjects'] as List).join(', ') : 'Unknown';

    return Oefeningen(
      subjects: subjects,
      info: Info.fromJson(json['info']),
    );
  }
}

class OefeningenService {
  Future<List<Oefeningen>> getOefeningen() async {
    final response = await http.get(Uri.parse('https://oefeningen'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Oefeningen.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load oefeningen');
    }
  }

  List<Oefeningen> filterOefeningenByFirstLetter(String letter, List<Oefeningen> oefeningen) {
    if (letter.isEmpty) {
      return oefeningen; // Return all oefeningen if search input is empty
    }

    return oefeningen.where((oefening) {
      return oefening.info.beschrijving.toLowerCase().startsWith(letter.toLowerCase());
    }).toList();
  }
}
