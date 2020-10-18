import 'package:find_your_pokemon_flutter_app/domain/bloc/data_bloc.dart';
import 'package:find_your_pokemon_flutter_app/domain/bloc/home_ui_bloc.dart';
import 'package:find_your_pokemon_flutter_app/domain/bloc/search_bloc.dart';
import 'package:find_your_pokemon_flutter_app/domain/provider/provider_bloc.dart';
import 'package:find_your_pokemon_flutter_app/presentation/screen/search_screen.dart';
import 'package:find_your_pokemon_flutter_app/presentation/widgets/pokemon_list_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DataBloc _dataBloc = BlocProvider.of<DataBloc>(context).bloc;
    final HomeUIBloc _homeUIBloc = HomeUIBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text("PokeDex"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider(
                        bloc: SearchBloc(
                            pokemonsList: _dataBloc.pokemonsInfoList),
                        child: SearchScreen(),
                      )));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text(
                  "Solar Power Filter",
                  style: TextStyle(fontSize: 24.0),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _homeUIBloc.isFilterApplied,
                  builder: (_, value, __) => Switch(
                    activeColor: Colors.deepOrangeAccent,
                    value: value,
                    onChanged: (value) {
                      _homeUIBloc.isFilterApplied.value = value;
                      if (value)
                        _homeUIBloc.index.value = 1;
                      else
                        _homeUIBloc.index.value = 0;
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: ValueListenableBuilder<int>(
                  valueListenable: _homeUIBloc.index,
                  builder: (_, value, __) => IndexedStack(
                        index: value,
                        children: <Widget>[
                          PokemonListView(
                            stream: _dataBloc.listPokemonStream,
                          ),
                          PokemonListView(
                            stream: _dataBloc.filterlistPokemonStream,
                          ),
                        ],
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
