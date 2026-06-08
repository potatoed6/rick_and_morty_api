import 'package:flutter/material.dart';
import '../data/character_api.dart';
import '../data/character.dart';
import 'character_detail_screen.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final api = CharacterApi();
  late Future<List<Character>> characters;

  @override
  void initState() {
    super.initState();
    characters = api.fetchCharacters();
  }

  Future<void> _refresh() async {
    setState(() {
      characters = api.fetchCharacters();
    });
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}