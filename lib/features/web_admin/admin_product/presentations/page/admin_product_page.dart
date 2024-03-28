import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_product/presentations/binding/admin_product_binding.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_product/presentations/widgets/admin_product_widget.dart';

class AdminAddProductPage extends StatelessWidget {
  const AdminAddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: AdminProductBinding.generateBloc,
      child: AdminProductWidget(),
    );
  }
}
