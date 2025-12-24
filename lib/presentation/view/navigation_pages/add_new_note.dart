import 'package:code_note/const/colors.dart';
import 'package:code_note/const/dimens.dart';
import 'package:code_note/core/controllers/category_controller.dart';
import 'package:code_note/core/models/category_model.dart';
import 'package:code_note/core/models/hive/note_model.dart';
import 'package:code_note/presentation/widgets/dropdowns/choose_lang_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewNotePage extends ConsumerStatefulWidget {
  const AddNewNotePage({super.key});

  @override
  ConsumerState<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends ConsumerState<AddNewNotePage> {

  late final TextEditingController _titleController;

  NoteLanguage _selectedLanguage = NoteLanguage.plainText; // --> Default value
  
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final categories = ref.watch(categoryControllerProvider);

    final size = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(Dimens.mainScaffoldPadding(context)),
      child: Column(
        children: [
          // appbar
          topAppBar(size, textTheme),

          SizedBox(height: size.height * .04),

          // title & lang
          Column(
            children: [
              // get title
              TextField(
                controller: _titleController,
                cursorColor: AppSolidColors.primary,
                style: textTheme.labelSmall!.copyWith(
                  color: Colors.white,
                ),
                decoration: _inputDecoration(textTheme),
              ),

              const SizedBox(height: 30),

              // choose language
              Container(
                width: size.width,
                height: size.width * .15,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppSolidColors.darkPurpleBackground,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: ChooseLangDropdown(
                  selectedLang: _selectedLanguage,
                  func: (NoteLanguage? value) {
                    if (value == null) return;
                    setState(() {
                      _selectedLanguage = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

              // choose category
              categoriesListView(categories),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox categoriesListView(List<NoteCategoryModel> categories) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.id == _selectedCategoryId;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryId = category.id;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppSolidColors.primary
                    : AppSolidColors.darkPurpleBackground,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(
                    category.icon,
                    size: 18,
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    category.name,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: isSelected ? Colors.white : Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(TextTheme textTheme) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.grey.shade700,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: AppSolidColors.primary.withValues(alpha: .5),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      labelText: 'عنوان یادداشت',
      labelStyle: textTheme.labelSmall!.copyWith(
        color: Colors.grey.shade600,
      ),
      hintText: 'کوتاه باشه بهتره',
      hintStyle: textTheme.labelSmall!.copyWith(
        color: Colors.grey.shade400,
      ),
    );
  }

  Container topAppBar(Size size, TextTheme textTheme) {
    return Container(
      height: size.height * .09,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppSolidColors.sectionDarkBackground,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [

          Text(
            'یادداشت جدید',
            style: textTheme.titleSmall!.copyWith(color: Colors.white),
          ),

          SizedBox(width: size.width * .1),

          Expanded(
            child: GestureDetector(
              onTap: () {
                
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppSolidColors.primary,
                  borderRadius: .circular(10)
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
              
                    Text(
                      'ذخیره',
                      style: textTheme.labelMedium!.copyWith(
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




// ref.read(notesControllerProvider.notifier).addNote(
//   NoteModel(
//     id: const Uuid().v4(),
//     title: _titleTextEditingController.text.trim(),
//     content: 'AsyncNotifier > StateNotifier',
//     type: NoteType.note.index,
//     categoryId: _selectedCategoryId ?? 2,
//     tags: ['flutter', 'riverpod'],
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//     language: _selectedLanguage,
//   ),
// );