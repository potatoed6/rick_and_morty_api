import 'package:hive/hive.dart';

class FavoritesCache {
  static const boxName = "favoritesBox";

  Future<void> toggleFavorite(int id) async {
    final box = await Hive.openBox(boxName);

    if (box.containsKey(id)) {
      await box.delete(id);
    } else {
      await box.put(id, true);
    }
  }

  Future<bool> isFavorite(int id) async {
    final box = await Hive.openBox(boxName);
    return box.containsKey(id);
  }

  Future<List<int>> getFavorites() async {
    final box = await Hive.openBox(boxName);
    return box.keys.map((e) => e as int).toList();
  }
}