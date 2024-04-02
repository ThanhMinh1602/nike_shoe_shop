import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/entities/models/user_model.dart';
import 'package:nike_shoe_shop/features/profile/presentations/binding/profile_binding.dart';
import 'package:nike_shoe_shop/features/profile/presentations/widgets/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ProfileBinding.generateBloc,
      child: ProfileWidget(userModel: userModel),
    );
  }
}
