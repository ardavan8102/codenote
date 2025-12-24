import 'package:code_note/const/colors.dart';
import 'package:code_note/core/controllers/page_handler_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackToHomeIconButton extends StatelessWidget {
  const BackToHomeIconButton({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref.read(pageHandlerControllerProvider.notifier).changePage(0);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppSolidColors.primary,
          borderRadius: .circular(8)
        ),
        child: Icon(
          Icons.home_filled,
          color: Colors.white,
        ),
      ),
    );
  }
}