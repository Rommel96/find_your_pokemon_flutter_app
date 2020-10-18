import 'package:find_your_pokemon_flutter_app/domain/api_global_interface.dart';
import 'package:flutter/material.dart';

class BlocProvider<T extends BLoC> extends StatefulWidget {
  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  final T bloc;
  final Widget child;

  static BlocProvider<T> of<T extends BLoC>(BuildContext context) =>
      context.findAncestorWidgetOfExactType();

  @override
  State<StatefulWidget> createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
