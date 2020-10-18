class Pokemon {
  int id;
  String name;
  String image;

  Pokemon({this.id, this.name, this.image});

  List<Pokemon> getListPokemonFromJSON(List json) {
    final List<Pokemon> listPokemon = [];
    json.forEach((e) {
      final id = e["entry_number"];
      final name = e["pokemon_species"]["name"];
      listPokemon.add(Pokemon(id: id, name: name));
    });

    return listPokemon;
  }
}
