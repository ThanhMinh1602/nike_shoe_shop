import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';

extension BuildContextExtension on BuildContext {
  T getBloc<T extends Bloc>() => BlocProvider.of<T>(this);

  AppNavigator getNavigator() => AppNavigator.fromContext(this);
}
