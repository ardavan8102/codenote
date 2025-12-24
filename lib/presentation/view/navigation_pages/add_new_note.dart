import 'package:code_note/const/colors.dart';
import 'package:code_note/const/dimens.dart';
import 'package:code_note/core/controllers/category_controller.dart';
import 'package:code_note/core/controllers/note_controller.dart';
import 'package:code_note/core/controllers/page_handler_controller.dart';
import 'package:code_note/core/helpers/note_type_extention.dart';
import 'package:code_note/core/models/category_model.dart';
import 'package:code_note/core/models/hive/note_model.dart';
import 'package:code_note/presentation/widgets/dropdowns/choose_lang_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends ConsumerStatefulWidget {
  const AddNewNotePage({super.key});

  @override
  ConsumerState<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends ConsumerState<AddNewNotePage> {

  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  NoteLanguage _selectedLanguage = NoteLanguage.plainText; // --> Default value
  
  int? _selectedCategoryId;

  NoteType _selectedNoteType = NoteType.note;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController();

    _contentController = TextEditingController();

  }

  @override
  void dispose() {
    _titleController.dispose();

    _contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final categories = ref.watch(categoryControllerProvider);

    final size = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(Dimens.mainScaffoldPadding(context)),
      child: SingleChildScrollView(
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
        
                // choose language & type
                Row(
                  spacing: 15,
                  children: [
                    
                    // language
                    Expanded(
                      child: Container(
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
                    ),
        
                    // type
                    GestureDetector(
                      onTap: () => _openNoteTypeSheet(context),
                      child: Container(
                        width: size.width * .15,
                        height: size.height * .065,
                        decoration: BoxDecoration(
                          color: AppSolidColors.darkPurpleBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _selectedNoteType.icon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 30),
        
                // choose category
                categoriesListView(categories),

                const SizedBox(height: 30),

                // content
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppSolidColors.darkPurpleBackground.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: TextFormField(
                    controller: _contentController,
                    maxLines: null,
                    keyboardType: .multiline,
                    textAlignVertical: .top,
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white70,
                      height: 1.5
                    ),
                    decoration: InputDecoration(
                      hintText: 'شروع به نوشتن کنید',
                      hintStyle: textTheme.labelMedium!.copyWith(
                        color: Colors.white.withValues(alpha: .6)
                      ),
                      border: .none,
                      focusedBorder: .none,
                      contentPadding: .zero,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // choose note type bottom sheet
  void _openNoteTypeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppSolidColors.sectionDarkBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: NoteType.values.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final type = NoteType.values[index];
              final isSelected = type == _selectedNoteType;

              return GestureDetector(
                onTap: () {

                  setState(() {

                    _selectedNoteType = type;

                  });
                  
                  Navigator.pop(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppSolidColors.primary
                        : AppSolidColors.darkPurpleBackground,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? AppSolidColors.primary
                          : Colors.grey.shade700,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(type.icon, color: Colors.white),
                      const SizedBox(height: 6),
                      Text(
                        type.label,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // choose category
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

  // title field decoration
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

  // top app bar
  Container topAppBar(Size size, TextTheme textTheme) {
    return Container(
      height: size.height * .09,
      padding: const EdgeInsets.fromLTRB(12, 12, 20, 12),
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
                _saveNote();

                _resetForm();

                ref.read(pageHandlerControllerProvider.notifier).changePage(1); // --> go to notes list
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

  // save note
  void _saveNote() {

    ref.read(notesControllerProvider.notifier).addNote(
      NoteModel(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        content: _contentController.text,
        type: _selectedNoteType.index,
        categoryId: _selectedCategoryId ?? 2,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        language: _selectedLanguage
      ),
    );

  }

  // reset form
  void _resetForm() {

    setState(() {
      _titleController.value = TextEditingValue.empty;
      _contentController.value = TextEditingValue.empty;

      _selectedLanguage = NoteLanguage.plainText;
      _selectedNoteType = NoteType.note;
      _selectedCategoryId = null;
    });

  }
}