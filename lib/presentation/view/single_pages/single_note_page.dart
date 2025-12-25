import 'package:code_note/const/colors.dart';
import 'package:code_note/const/dimens.dart';
import 'package:code_note/core/controllers/category_controller.dart';
import 'package:code_note/core/helpers/language_extention.dart';
import 'package:code_note/core/helpers/note_type_extention.dart';
import 'package:code_note/core/models/hive/note_model.dart';
import 'package:code_note/presentation/widgets/appbars/title_with_back_button.dart';
import 'package:code_note/presentation/widgets/code_hightlight_view.dart';
import 'package:code_note/presentation/widgets/home_big_banner_container.dart';
import 'package:code_note/presentation/widgets/rows/note_meta_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SingleNotePage extends ConsumerWidget {
  const SingleNotePage({super.key, required this.note});

  final NoteModel note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final category = ref.read(categoryControllerProvider.notifier).getCategoryById(note.categoryId);

    final size = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppSolidColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimens.mainScaffoldPadding(context)),
          child: Column(
            children: [

              // appbar
              TopAppBarTitleWithBackButton(title: note.title),

              const SizedBox(height: 30),

              // meta data
              BigBannerContainer(
                useShadow: true,
                bgColor: AppSolidColors.primary,
                child: Padding(
                  padding: const EdgeInsetsGeometry.fromLTRB(24, 18, 24, 18),
                  child: Column(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      SingleNoteMetaDataRow(value: category!.name, label: 'دسته بندی'),
          
                      SingleNoteMetaDataRow(value: note.language.displayName, label: 'زبان'),
          
                      SingleNoteMetaDataRow(value: NoteType.values[note.type].label, label: 'نوع'),
                    ],
                  ),
                ),
              ),
          
              const SizedBox(height: 30),

              // content
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Code view
                      CodeHightlightViewer(note: note),
                  
                      const SizedBox(height: 30),
                  
                      Container(
                        width: size.width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppSolidColors.darkPurpleBackground,
                          borderRadius: .circular(15)
                        ),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              'توضیحات:',
                              style: textTheme.titleMedium!.copyWith(
                                color: Colors.white
                              ),
                            ),

                            const SizedBox(height: 10),
                            
                            Text(
                              note.content,
                              style: textTheme.labelMedium!.copyWith(
                                color: Colors.white.withValues(alpha: .7),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}