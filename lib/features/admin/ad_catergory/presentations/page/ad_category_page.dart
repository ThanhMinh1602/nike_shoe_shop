import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/admin/ad_catergory/presentations/binding/ad_category_binding.dart';
import 'package:nike_shoe_shop/features/admin/ad_catergory/presentations/widgets/ad_category_widget.dart';

class AdCategoryPage extends StatelessWidget {
  const AdCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: AdCategoryBinding.generateBloc,
      child: AdCategoryWidget(),
    );
  }
}
