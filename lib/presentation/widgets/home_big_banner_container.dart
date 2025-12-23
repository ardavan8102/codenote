import 'package:flutter/material.dart';

class HomeBigBannerContainer extends StatelessWidget {
  const HomeBigBannerContainer({
    super.key,
    required this.useShadow,
    required this.bgColor,
    required this.child,
  });

  final bool useShadow;
  final Color bgColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .16,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: .circular(20),
        boxShadow: useShadow
            ? [
                BoxShadow(
                  color: bgColor.withValues(alpha: .5),
                  offset: Offset(15, 0),
                  spreadRadius: 2,
                  blurRadius: 30,
                ),

                BoxShadow(
                  color: bgColor.withValues(alpha: .5),
                  offset: Offset(-15, 0),
                  spreadRadius: 2,
                  blurRadius: 30,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
