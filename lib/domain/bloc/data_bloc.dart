import 'dart:async';

import 'package:find_your_pokemon_flutter_app/data/pokeapi_connection.dart';
import 'package:find_your_pokemon_flutter_app/data/pokemon.dart';
import 'package:find_your_pokemon_flutter_app/domain/api_global_interface.dart';

class DataBloc implements BLoC {
  final StreamController<List<Pokemon>> _listPokemonCtrll =
      StreamController<List<Pokemon>>();
  final StreamController<List<Pokemon>> _filterListPokemonCtrll =
      StreamController<List<Pokemon>>();

  List<Pokemon> pokemonsInfoList = [];
  Stream<List<Pokemon>> get listPokemonStream => _listPokemonCtrll.stream;
  Stream<List<Pokemon>> get filterlistPokemonStream =>
      _filterListPokemonCtrll.stream;

  Future<void> getSolarPokemons() async {
    final List<Pokemon> _solarPower = [];
    final List result = await PokeApiConnections.searchSolarPokemon();
    result.forEach((pokemonInfo) {
      final String name = pokemonInfo["pokemon"]["name"];
      final String url = pokemonInfo["pokemon"]["url"];
      final int id = int.parse(url.split("/").elementAt(6));
      _solarPower.add(Pokemon(
          id: id,
          name: name,
          image: id > 151
              ? "assets/images/not-found.png"
              : id > 10
                  ? "assets/images/0$id.png"
                  : "assets/images/00$id.png"));
    });
    _filterListPokemonCtrll.sink.add(_solarPower);
  }

  Future<String> getPokemonDescriptionES(int id) async {
    String _descriprionEs;
    final List descriptions = await PokeApiConnections.getDescription(id);
    descriptions.forEach((description) {
      if (description["language"]["name"] == "es") {
        _descriprionEs = description["flavor_text"];
        return;
      }
    });
    return _descriprionEs;
  }

  Future<List<String>> getPokemonAbilities(int id) async {
    final List<String> _listResult = [];
    final List abilities = await PokeApiConnections.getAbilities(id);
    abilities.forEach((abilitie) {
      _listResult.add(abilitie["ability"]["name"]);
    });
    return _listResult;
  }

  Future<void> getAllPokemons() async {
    final result = await PokeApiConnections.getPokemons();
    final pokemonList = Pokemon().getListPokemonFromJSON(result);
    pokemonList.forEach((Pokemon pokemon) {
      if (pokemon.id < 10)
        pokemon.image = "assets/images/00${pokemon.id}.png";
      else if (pokemon.id < 100)
        pokemon.image = "assets/images/0${pokemon.id}.png";
      else
        pokemon.image = "assets/images/${pokemon.id}.png";
    });
    pokemonsInfoList = pokemonList;
    _listPokemonCtrll.sink.add(pokemonList);
  }

  @override
  void dispose() {
    _listPokemonCtrll.close();
    _filterListPokemonCtrll.close();
  }
}
