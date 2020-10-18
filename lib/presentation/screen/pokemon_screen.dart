import 'package:find_your_pokemon_flutter_app/data/pokemon.dart';
import 'package:find_your_pokemon_flutter_app/domain/bloc/data_bloc.dart';
import 'package:find_your_pokemon_flutter_app/domain/provider/provider_bloc.dart';
import 'package:flutter/material.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({Key key, this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final DataBloc _bloc = BlocProvider.of<DataBloc>(context).bloc;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemon.name.toUpperCase(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.asset(
                  pokemon.image,
                ),
              ),
            ),
            FutureBuilder(
              future: _bloc.getPokemonDescriptionES(pokemon.id),
              initialData: "",
              builder: (_, AsyncSnapshot<String> snapshot) {
                return Text(
                  snapshot.data,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 18.0,
            ),
            FutureBuilder(
              future: _bloc.getPokemonAbilities(pokemon.id),
              initialData: List<String>(),
              builder: (_, AsyncSnapshot<List<String>> snapshot) {
                final _abilities = snapshot.data;
                if (snapshot.hasData) {
                  return Expanded(
                      child: ListView.separated(
                          separatorBuilder: (_, __) => const SizedBox(
                                height: 16.0,
                              ),
                          itemCount: _abilities.length,
                          itemBuilder: (_, index) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              color: Colors.black38,
                              child: Text(_abilities[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  )),
                            );
                          }));
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
