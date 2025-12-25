import 'package:code_note/const/dimens.dart';
import 'package:code_note/core/controllers/category_controller.dart';
import 'package:code_note/core/helpers/get_now_shamsi_date.dart';
import 'package:code_note/presentation/widgets/home_big_banner.dart';
import 'package:code_note/presentation/widgets/home_category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var textTheme = Theme.of(context).textTheme;

    var size = MediaQuery.of(context).size;

    final defaultCategories = ref.watch(categoryControllerProvider);

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

          // Big Banner
          SizedBox(
            height: size.height * .16,
            width: size.width,
            child: HomeBigBanner(),
          ),

          const SizedBox(height: 50),

          // Default Categories
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20
              ),
              itemCount: defaultCategories.length,
              itemBuilder: (context, index) {

                final category = defaultCategories[index];
                
                final noteCount = ref.watch(categoryNoteCountProvider(category.id));

                return HomeDefaultCategoryCard(
                  icon: category.icon,
                  title: category.name, 
                  subtitle: '$noteCount یادداشت',
                );
                
              },
            )
          ),
        ],
      ),
    );
  }
}

