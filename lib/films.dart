import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_project_6/main.dart';

const allFilms = [
  Film(
    id: '1',
    title: "The Shawshank Redemption",
    description: "Description for The Shawshank Redemption",
    isFavorite: false,
  ),
  Film(
    id: '2',
    title: "The Godfather",
    description: "Description for The Godfather",
    isFavorite: false,
  ),
  Film(
    id: '3',
    title: "The Godfather: Part II",
    description: "Description for The Godfather Part II",
    isFavorite: false,
  ),
  Film(
    id: '4',
    title: "The Dark Knight",
    description: "Description for The Dark Knight",
    isFavorite: false,
  ),
];

class FilmsNotifier extends StateNotifier<List<Film>> {
  FilmsNotifier() : super(allFilms);

  void update(Film film, bool isFavorite) {
    state = state
        .map((thisFilm) => thisFilm.id == film.id
            ? thisFilm.copy(isFavorite: isFavorite)
            : thisFilm)
        .toList();
  }
}

enum FavoriteStatus {
  all,
  favorite,
  notFavorite,
}

final favoriteStatusProvider = StateProvider<FavoriteStatus>(
  (_) => FavoriteStatus.all,
);

// all films
final allFimsProvider =
    StateNotifierProvider<FilmsNotifier, List<Film>>((_) => FilmsNotifier());

//favorite films
final favoriteFilmsProvider = Provider<Iterable<Film>>(
    (ref) => ref.watch(allFimsProvider).where((film) => film.isFavorite));

//not favorite films
final notFavoriteFilmsProvider = Provider<Iterable<Film>>(
    (ref) => ref.watch(allFimsProvider).where((film) => !film.isFavorite));

class FilmsList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  const FilmsList({required this.provider, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
      child: ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films.elementAt(index);

          final favoriteIcon = film.isFavorite
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border);

          return ListTile(
            title: Text(film.title),
            subtitle: Text(film.description),
            trailing: IconButton(
              icon: favoriteIcon,
              onPressed: () {
                final isFavorite = !film.isFavorite;
                ref.read(allFimsProvider.notifier).update(
                      film,
                      isFavorite,
                    );
              },
            ),
          );
        },
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return DropdownButton(
          value: ref.watch(favoriteStatusProvider),
          items: FavoriteStatus.values.map((fs) =>
          DropdownMenuItem
          (
             value: fs,
            child: Text(fs.toString().split(".").last),
          )
          ).toList(),
           onChanged: (FavoriteStatus ? fs) {
            ref.read(favoriteStatusProvider.state).state = fs!;
           },
           );
      },
    );
  }
}
