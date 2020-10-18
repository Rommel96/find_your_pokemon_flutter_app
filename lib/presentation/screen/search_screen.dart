import 'package:find_your_pokemon_flutter_app/data/pokemon.dart';
import 'package:find_your_pokemon_flutter_app/domain/bloc/search_bloc.dart';
import 'package:find_your_pokemon_flutter_app/domain/provider/provider_bloc.dart';
import 'package:find_your_pokemon_flutter_app/presentation/screen/pokemon_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _searchBloc = BlocProvider.of<SearchBloc>(context).bloc;
    return Scaffold(
      appBar: AppBar(
        title: Text("Find your Pokemon"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) => _searchBloc.updateString(value),
              decoration: InputDecoration(
                  hintText: 'Search', prefixIcon: Icon(Icons.search)),
            ),
            StreamBuilder<List<Pokemon>>(
              stream: _searchBloc.streamSearch,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        final pokemon = snapshot.data[index];
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => PokemonScreen(
                                      pokemon: pokemon,
                                    )));
                          },
                          leading: Image.asset(pokemon.image),
                          title: Text("${pokemon.name}"),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
