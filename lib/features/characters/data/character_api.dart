import 'dart:convert';
import 'package:http/http.dart' as http;
import 'character.dart';

class CharacterApi {
  static const String baseUrl =
      "https://rickandmortyapi.com/api/character";

  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      return results.map((e) => Character.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load characters");
    }
  }
}