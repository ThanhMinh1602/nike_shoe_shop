import 'package:flutter/widgets.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/home/presentations/bloc/home_bloc.dart';

class HomeBinding {
  static HomeBloc generateBloc(BuildContext context) {
    return HomeBloc(
      appNavigator: context.getNavigator(),
    );
  }
}
