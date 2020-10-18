import 'package:find_your_pokemon_flutter_app/data/pokemon.dart';
import 'package:find_your_pokemon_flutter_app/presentation/screen/pokemon_screen.dart';
import 'package:flutter/material.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({Key key, this.stream}) : super(key: key);
  final Stream<List<Pokemon>> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (_, snapshot) {
          if (snapshot.hasData)
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (_, index) {
                final pokemon = snapshot.data[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => PokemonScreen(
                              pokemon: pokemon,
                            )));
                  },
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset(pokemon.image),
                      )),
                      Text(pokemon.name)
                    ],
                  ),
                );
              },
              itemCount: snapshot.data.length,
            );
          return const SizedBox.shrink();
        });
  }
}
