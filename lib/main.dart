import 'package:find_your_pokemon_flutter_app/domain/bloc/data_bloc.dart';
import 'package:find_your_pokemon_flutter_app/domain/provider/provider_bloc.dart';
import 'package:find_your_pokemon_flutter_app/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DataBloc>(
      bloc: DataBloc()
        ..getAllPokemons()
        ..getSolarPokemons(),
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
        title: 'Find Your Pokemon',
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
