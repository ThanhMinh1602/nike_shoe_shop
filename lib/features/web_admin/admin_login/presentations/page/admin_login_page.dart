import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_login/presentations/binding/admin_login_binding.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_login/presentations/widgets/admin_login_widget.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProvider(
      create: AdminLoginBinding.generateBloc,
      child: AdminLoginWidget(),
    );
  }
}
