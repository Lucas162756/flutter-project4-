import 'package:http/http.dart' as http;
import 'dart:convert';

class Info {
  final int gebruikers_id;
  final int Oefeningen_id;
  final int score;

  const Info({
    required this.gebruikers_id,
    required this.Oefeningen_id,
    required this.score,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      gebruikers_id: json['gebruikers_id'] ?? 0, // Ensure 'gebruikers_id' field is present
      Oefeningen_id: json['Oefeningen_id'] ?? 0, // Ensure 'Oefeningen_id' field is present
      score: json['score'] ?? 0, // Ensure 'score' field is present
    );
  }
}

class Prestatie {
  final String subjects;
  final Info info;

  const Prestatie({
    required this.subjects,
    required this.info,
  });

  factory Prestatie.fromJson(Map<String, dynamic> json) {
    // Assuming subjects is a List of strings, and joining them as a single string
    String subjects = json['subjects'] != null ? (json['subjects'] as List).join(', ') : 'Unknown';

    return Prestatie(
      subjects: subjects,
      info: Info.fromJson(json['info']),
    );
  }
}

class PrestatieService {
  Future<List<Prestatie>> getPrestaties() async {
    final response = await http.get(Uri.parse('https://api_url.com/prestaties'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Prestatie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load prestaties');
    }
  }

  List<Prestatie> filterPrestatiesByFirstLetter(String letter, List<Prestatie> prestaties) {
    if (letter.isEmpty) {
      return prestaties; // Return all prestaties if search input is empty
    }

    return prestaties.where((prestatie) {
      return prestatie.info.gebruikers_id.toString().startsWith(letter.toLowerCase());
    }).toList();
  }
}
