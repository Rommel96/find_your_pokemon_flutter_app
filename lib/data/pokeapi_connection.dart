import 'dart:convert';

import 'package:find_your_pokemon_flutter_app/data/endpoints.dart';
import 'package:http/http.dart' as http;

class PokeApiConnections {
  static getPokemons() async {
    final result = await http.get(EndPoints.pokemons);
    final dataDecoded = jsonDecode(result.body);
    return dataDecoded["pokemon_entries"];
  }

  static searchSolarPokemon() async {
    final result = await http.get(EndPoints.solarPower);
    final dataDecoded = jsonDecode(result.body);
    return dataDecoded["pokemon"];
  }

  static getDescription(int id) async {
    final result = await http.get("${EndPoints.pokemonDescription}$id");
    final dataDecoded = jsonDecode(result.body);
    return dataDecoded["flavor_text_entries"];
  }

  static getAbilities(int id) async {
    final result = await http.get("${EndPoints.pokemonAbilities}$id");
    final dataDecoded = jsonDecode(result.body);
    return dataDecoded["abilities"];
  }
}
