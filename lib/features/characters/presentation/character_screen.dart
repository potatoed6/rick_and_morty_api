import 'package:flutter/material.dart';
import '../data/character_api.dart';
import '../data/character.dart';
import 'character_detail_screen.dart';
import '../data/favs_cache.dart';
import '../data/character_cache.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final api = CharacterApi();
  final favCache = FavoritesCache();
  final cache = CharacterCache();
  late Future<List<Character>> characters;

  @override
  void initState() {
    super.initState();
    characters = api.fetchCharacters();
  }

  Future<void> _refresh() async {
    setState(() {
      characters = _loadCharacters();
    });
  }

  Future<List<Character>> _loadCharacters() async {
    try {
      final data = await api.fetchCharacters();
      await cache.saveCharacters(data);
      return data;
    } catch (e) {
      return await cache.getCharacters();
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rick & Morty Characters")),
      body: FutureBuilder<List<Character>>(
        future: characters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          }

          final data = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final c = data[index];
                final isFav = favCache.isFavorite(c.id);

                return ListTile(
                  leading: Image.network(c.image),
                  title: Text(c.name),
                  subtitle: Text("${c.species} • ${c.status}"),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CharacterDetailScreen(character: c),
                      ),
                    );
                  },

                  trailing: FutureBuilder<bool>(
                    future: favCache.isFavorite(c.id),
                    builder: (context, snapshot) {
                      final isFav = snapshot.data ?? false;

                      return IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                        onPressed: () async {
                          await favCache.toggleFavorite(c.id);
                          setState(() {});
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}