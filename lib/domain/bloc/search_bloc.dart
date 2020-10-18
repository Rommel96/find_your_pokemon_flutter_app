import 'dart:async';

import 'package:find_your_pokemon_flutter_app/data/pokemon.dart';
import 'package:find_your_pokemon_flutter_app/domain/api_global_interface.dart';

class SearchBloc implements BLoC {
  SearchBloc({this.pokemonsList});

  final List<Pokemon> pokemonsList;
  final StreamController<List<Pokemon>> _controller =
      StreamController<List<Pokemon>>();

  Stream<List<Pokemon>> get streamSearch => _controller.stream;

  void updateString(String value) {
    final List<Pokemon> _search = [];
    if (value.isNotEmpty) {
      pokemonsList.forEach((Pokemon p) {
        if (p.name.startsWith(value)) {
          _search.add(p);
        }
      });
    }
    _controller.sink.add(_search);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
