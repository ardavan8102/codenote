import 'package:code_note/const/colors.dart';
import 'package:code_note/core/helpers/language_extention.dart';
import 'package:code_note/core/models/hive/note_model.dart';
import 'package:flutter/material.dart';

class ChooseLangDropdown extends StatelessWidget {
  const ChooseLangDropdown({super.key, required this.selectedLang, required this.func});

  final NoteLanguage selectedLang;
  final ValueChanged<NoteLanguage?> func;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;
    
    return DropdownButtonHideUnderline(
      child: DropdownButton<NoteLanguage>(
        value: selectedLang,
        dropdownColor: AppSolidColors.sectionDarkBackground,
        borderRadius: BorderRadius.circular(12),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
        menuMaxHeight: size.height * .3,

        onChanged: func,

        items: NoteLanguage.values.map((language) {
          return DropdownMenuItem<NoteLanguage>(
            value: language,
            child: Row(
              children: [
                Image.asset(
                  language.displayImage,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 15),
                Text(
                  language.displayName,
                  style: textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}