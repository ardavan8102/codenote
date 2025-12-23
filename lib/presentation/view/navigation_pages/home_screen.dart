import 'package:code_note/const/dimens.dart';
import 'package:code_note/core/helpers/get_now_shamsi_date.dart';
import 'package:code_note/presentation/widgets/home_big_banner.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var textTheme = Theme.of(context).textTheme;

    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(Dimens.mainScaffoldPadding(context)),
      child: Column(
        crossAxisAlignment: .start,
        children: [

          // Welcome Text
          Column(
            crossAxisAlignment: .start,
            children: [
          
              Text(
                'سلام مهندس',
                style: textTheme.labelMedium!.copyWith(
                  color: Colors.white.withValues(alpha: .6)
                ),
              ),
          
              const SizedBox(height: 15),
          
              Text(
                'امروز ${getNowDate()}',
                style: textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 28
                ),
              ),
            ],
          ),


          const SizedBox(height: 30),

          SizedBox(
            height: size.height * .16,
            width: size.width,
            child: HomeBigBanner(),
          )
        ],
      ),
    );
  }
}