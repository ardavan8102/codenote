import 'package:code_note/const/colors.dart';
import 'package:code_note/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class HomeDefaultCategoryCard extends StatelessWidget {
  const HomeDefaultCategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(right: 20),
      height: size.height * .18,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.img.cardBg.path),
          fit: .fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppSolidColors.primary.withValues(alpha: .2),
              shape: .circle,
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: AppSolidColors.primary),
          ),
    
          const SizedBox(height: 12),
    
          Text(
            title,
            style: textTheme.labelMedium!.copyWith(
              color: AppSolidColors.primary,
            ),
          ),
    
          const SizedBox(height: 8),
    
          Text(
            subtitle,
            style: textTheme.labelSmall!.copyWith(
              color: Colors.white.withValues(alpha: .7),
            ),
          ),
        ],
      ),
    );
  }
}
