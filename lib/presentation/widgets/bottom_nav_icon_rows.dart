import 'package:code_note/const/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationBarIconRows extends StatelessWidget {
  const BottomNavigationBarIconRows({
    super.key,
    required this.currentPageIndex,
    required this.ref,
    required this.isLeft,
    required this.widgets,
  });

  final int currentPageIndex;
  final WidgetRef ref;
  final bool isLeft;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {

    if (isLeft) {

      return Positioned(
        left: 20,
        top: 0,
        bottom: 0,
        child: Row(
          spacing: Dimens.bottomNavBarIconSpacing,
          children: widgets,
        ),
      );

    } else {

      return Positioned(
        right: 20,
        top: 0,
        bottom: 0,
        child: Row(
          spacing: Dimens.bottomNavBarIconSpacing,
          children: widgets,
        ),
      );

    }
    
  }
}