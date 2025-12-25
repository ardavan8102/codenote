import 'package:code_note/const/colors.dart';
import 'package:flutter/material.dart';

class TopAppBarJustText extends StatelessWidget {
  const TopAppBarJustText({
    super.key, required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: size.height * .08,
      width: size.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppSolidColors.sectionDarkBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: .center,
      child: Text(
        title,
        style: textTheme.titleSmall!.copyWith(color: Colors.white),
      ),
    );
  }
}