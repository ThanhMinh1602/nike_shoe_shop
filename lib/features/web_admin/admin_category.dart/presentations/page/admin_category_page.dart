import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_category.dart/presentations/binding/admin_category_binding.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_category.dart/presentations/widgets/admin_category_widget.dart';

class AdminCategoryPage extends StatelessWidget {
  const AdminCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProvider(
      create: AdminCategoryBinding.generateBloc,
      child: AdminCategoryWidget(),
    );
  }
}
