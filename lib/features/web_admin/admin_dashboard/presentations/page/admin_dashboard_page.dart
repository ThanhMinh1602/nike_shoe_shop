import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_dashboard/presentations/binding/admin_dashboard_binding.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_dashboard/presentations/widgets/admin_dashboard_widget.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProvider(
      create: AdminDashBoardBinding.generateBloc,
      child: AdminDashboardWidget(),
    );
  }
}
