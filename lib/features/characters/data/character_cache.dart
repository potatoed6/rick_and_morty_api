import 'package:hive/hive.dart';
import 'character.dart';

class CharacterCache {
  static const String boxName = "charactersBox";

  Future<void> saveCharacters(List<Character> characters) async {
    final box = await Hive.openBox(boxName);

    final data = characters
        .map((c) => {
      "id": c.id,
      "name": c.name,
      "image": c.image,
      "status": c.status,
      "species": c.species,
    })
        .toList();

    await box.put("list", data);
  }

  Future<List<Character>> getCharacters() async {
    final box = await Hive.openBox(boxName);

    final data = box.get("list", defaultValue: []);

    return (data as List)
        .map((e) => Character(
      id: e["id"],
      name: e["name"],
      image: e["image"],
      status: e["status"],
      species: e["species"],
    ))
        .toList();
  }
}