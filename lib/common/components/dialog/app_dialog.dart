import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    this.onPressedYes,
    this.title,
    this.content,
  });
  final VoidCallback? onPressedYes;
  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(title ?? ''),
      content: Text(content ?? ''),
      actions: [
        TextButton(
          onPressed: () {
            context.getNavigator().pop();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            onPressedYes!();
            context.getNavigator().pop();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
