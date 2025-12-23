import 'package:code_note/const/colors.dart';
import 'package:code_note/core/controllers/page_handler_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationIconButton extends StatelessWidget {
  const BottomNavigationIconButton({
    super.key,
    required this.currentPageIndex,
    required this.ref,
    required this.getToPageIndex,
    required this.imgAsset
  });

  final int currentPageIndex;
  final WidgetRef ref;
  final int getToPageIndex;
  final String imgAsset;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ref.read(pageHandlerControllerProvider.notifier).changePage(getToPageIndex);
      },
      child: SvgPicture.asset(
        imgAsset,
        width: 32,
        height: 32,
        colorFilter: ColorFilter.mode(
          currentPageIndex == getToPageIndex
            ? AppSolidColors.iconActive
            : AppSolidColors.iconInActive,
          BlendMode.srcIn
        ),
      ),
    );
  }
}