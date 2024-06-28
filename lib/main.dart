import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_project_6/films.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

@immutable
class Film {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Film(
      {required this.id,
      required this.title,
      required this.description,
      required this.isFavorite});

  Film copy({required bool isFavorite}) => Film(
        id: id,
        title: title,
        description: description,
        isFavorite: isFavorite,
      );

  @override
  String toString() => 'Film(id: $id,'
      'title: $title,'
      'description: $description,'
      'isFavorite: $isFavorite,)';

  @override
  bool operator ==(covariant Film other) =>
      id == other.id && isFavorite == other.isFavorite;

  @override
  int get hashCode => Object.hashAll([
        id,
        isFavorite,
      ]);
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(66, 59, 58, 58),
        title: const Text('Films'),
        centerTitle: true,
      ),
      body: Column(children: [
        const FilterWidget(),
        Consumer(builder: (context, ref, child) {
          final filter = ref.watch(favoriteStatusProvider);
          switch (filter) { 
            case FavoriteStatus.all:
              return FilmsList(provider: allFimsProvider);
            case FavoriteStatus.favorite:
              return FilmsList(provider: favoriteFilmsProvider);
            case FavoriteStatus.notFavorite:
              return FilmsList(provider: notFavoriteFilmsProvider);
          }
        })
        // const FilmsWidget(provider: provider)
      ]),
    );
  }
}
