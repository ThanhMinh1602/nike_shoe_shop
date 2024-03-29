import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/admin/ad_home/presentations/binding/ad_home_binding.dart';
import 'package:nike_shoe_shop/features/admin/ad_home/presentations/widgets/ad_home_widget.dart';

class AdHomePage extends StatelessWidget {
  const AdHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProvider(
      create: AdHomeBinding.generateBloc,
      child: AdHomeWidget(),
    );
  }
}
