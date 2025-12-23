import 'package:code_note/const/colors.dart';
import 'package:code_note/const/strings.dart';
import 'package:code_note/gen/assets.gen.dart';
import 'package:code_note/presentation/widgets/home_big_banner_container.dart';
import 'package:flutter/material.dart';

class HomeBigBanner extends StatelessWidget {
  const HomeBigBanner({super.key});

  @override
  Widget build(BuildContext context) {

    var textTheme = Theme.of(context).textTheme;

    var size = MediaQuery.of(context).size;
    
    return Stack(
      clipBehavior: Clip.none,
      children: [
        

        // Opacity 25%
        Positioned(
          left: size.width * .16,
          right: size.width * .16,
          bottom: -40,
          child: HomeBigBannerContainer(
            bgColor: AppSolidColors.primary.withValues(alpha: .25),
            useShadow: false,
            child: const SizedBox.shrink(),
          ),
        ),

        // Opacity 60%
        Positioned(
          left: size.width * .08,
          right: size.width * .08,
          bottom: -20,
          child: HomeBigBannerContainer(
            bgColor: AppSolidColors.primary.withValues(alpha: .5),
            useShadow: false,
            child: const SizedBox.shrink(),
          ),
        ),


        // Opacity 100%
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: HomeBigBannerContainer(
            bgColor: AppSolidColors.primary,
            useShadow: true,
            child: Stack(
              alignment: .centerRight,
              clipBehavior: .none,
              children: [

                // circle overlays
                Positioned(
                  left: 30,
                  bottom: 30,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .15),
                      shape: .circle,
                    ),
                  ),
                ),

                Positioned(
                  left: 150,
                  bottom: 100,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .08),
                      shape: .circle,
                    ),
                  ),
                ),

                // image
                Positioned(
                  left: -20,
                  bottom: -10,
                  child: Image.asset(
                    Assets.img.notepad.path,
                    width: 150,
                    height: 150,
                  ),
                ),

                Positioned(
                  right: 20,
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        AppStrings.homeBigBannerTitle,
                        style: textTheme.titleLarge!.copyWith(
                          color: Colors.white
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        AppStrings.homeBigBannerSubTitle,
                        style: textTheme.labelSmall!.copyWith(
                          color: Colors.white.withValues(alpha: .7)
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}