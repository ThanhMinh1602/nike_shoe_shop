import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';

extension BuildContextExtension on BuildContext {
  T getBloc<T extends Bloc>() => BlocProvider.of<T>(this);

  AppNavigator getNavigator() => AppNavigator.fromContext(this);

  double getWidth({double? ratio}) =>
      MediaQuery.of(this).size.width * (ratio ?? 1.0);
  double getHeight({double? ratio}) =>
      MediaQuery.of(this).size.height * (ratio ?? 1.0);
}
