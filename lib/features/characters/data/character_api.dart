import 'dart:convert';
import 'package:http/http.dart' as http;
import 'character.dart';
import 'character_cache.dart';

class CharacterApi {
  static const String baseUrl =
      "https://rickandmortyapi.com/api/character";

  final cache = CharacterCache();

  Future<List<Character>> fetchCharacters() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];

        final characters =
        results.map((e) => Character.fromJson(e)).toList();

        await cache.saveCharacters(characters);

        return characters;
      } else {
        throw Exception("API error");
      }
    } catch (e) {
      // OFFLINE FALLBACK
      return await cache.getCharacters();
    }
  }
}