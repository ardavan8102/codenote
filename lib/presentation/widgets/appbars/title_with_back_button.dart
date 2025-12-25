import 'package:code_note/const/colors.dart';
import 'package:flutter/material.dart';

class TopAppBarTitleWithBackButton extends StatelessWidget {
  const TopAppBarTitleWithBackButton({
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
      padding: const EdgeInsets.fromLTRB(12, 12, 18, 12),
      decoration: BoxDecoration(
        color: AppSolidColors.sectionDarkBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: .center,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.titleSmall!.copyWith(color: Colors.white),
            maxLines: 1,
            overflow: .ellipsis,
          ),

          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}