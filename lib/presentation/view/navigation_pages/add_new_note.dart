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
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/css.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/go.dart';
import 'package:highlight/languages/htmlbars.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/kotlin.dart';
import 'package:highlight/languages/php.dart';
import 'package:highlight/languages/plaintext.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/ruby.dart';
import 'package:highlight/languages/rust.dart';
import 'package:highlight/languages/sql.dart';
import 'package:highlight/languages/swift.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends ConsumerStatefulWidget {
  const AddNewNotePage({super.key});

  @override
  ConsumerState<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends ConsumerState<AddNewNotePage> {

  late final TextEditingController _titleController;

  late final TextEditingController _contentController;

  late final CodeController _codeController;

  final _scrollController = ScrollController();

  final _contentFocus = FocusNode();

  final _codeFocus = FocusNode();

  NoteLanguage _selectedLanguage = NoteLanguage.plainText; // --> Default value
  
  int? _selectedCategoryId;

  NoteType _selectedNoteType = NoteType.note;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController();

    _contentController = TextEditingController();

    _codeController = CodeController(
      text: '',
      language: plaintext,
    );

    _contentFocus.addListener(
      () {
        if (_contentFocus.hasFocus) _scrollToFocused();
      }
    );

    _codeFocus.addListener(
      () {
        if (_codeFocus.hasFocus) _scrollToFocused();
      }
    );
  }

  @override
  void dispose() {
    _titleController.dispose();

    _contentController.dispose();

    _codeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final categories = ref.watch(categoryControllerProvider);

    final size = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;
    
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        top: Dimens.mainScaffoldPadding(context),
        left: Dimens.mainScaffoldPadding(context),
        right: Dimens.mainScaffoldPadding(context),
        bottom: bottomInset
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
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
                              _codeController.language = switch (value) {
                                NoteLanguage.dart => dart,
                                NoteLanguage.cpp => cpp,
                                NoteLanguage.javascript => javascript,
                                NoteLanguage.python => python,
                                NoteLanguage.java => java,
                                NoteLanguage.swift => swift,
                                NoteLanguage.kotlin => kotlin,
                                NoteLanguage.php => php,
                                NoteLanguage.ruby => ruby,
                                NoteLanguage.go => go,
                                NoteLanguage.rust => rust,
                                NoteLanguage.sql => sql,
                                NoteLanguage.html => htmlbars,
                                NoteLanguage.css => css,
                                NoteLanguage.plainText => plaintext,
                              };
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
                    focusNode: _contentFocus,
                    controller: _contentController,
                    maxLines: null,
                    minLines: 1,
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


                const SizedBox(height: 20),

                // code editor
                codeEditor(textTheme),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget codeEditor(TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        color: AppSolidColors.sectionDarkBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 12),
            child: Text(
              'یادداشت کُد',
              style: textTheme.labelSmall!.copyWith(
                color: Colors.grey.shade400,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // editor
          Directionality(
            textDirection: .ltr,
            child: CodeTheme(
              data: CodeThemeData(styles: atomOneDarkTheme),
              child: CodeField(
                focusNode: _codeFocus,
                controller: _codeController,
                textStyle: textTheme.bodySmall!.copyWith(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 14,
                  color: Colors.white
                ),
                expands: false,
                minLines: 4,
                maxLines: null,
                background: Colors.transparent,
              ),
            ),
          ),
        ],
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

  // scroll manager for text fields
  void _scrollToFocused() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // save note
  void _saveNote() {

    ref.read(notesControllerProvider.notifier).addNote(
      NoteModel(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        content: _contentController.text,
        codeContent: _codeController.text,
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
      _codeController.text = '';

      _selectedLanguage = NoteLanguage.plainText;
      _selectedNoteType = NoteType.note;
      _selectedCategoryId = null;
    });

  }
}