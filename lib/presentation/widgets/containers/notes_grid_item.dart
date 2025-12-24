import 'package:code_note/const/colors.dart';
import 'package:code_note/core/helpers/language_extention.dart';
import 'package:code_note/core/models/hive/note_model.dart';
import 'package:flutter/material.dart';

class NotesGridViewItem extends StatelessWidget {
  const NotesGridViewItem({
    super.key,
    required this.size,
    required this.note,
    required this.textTheme,
  });

  final Size size;
  final NoteModel note;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * .5,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppSolidColors.darkPurpleBackground.withValues(alpha: .4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,
        children: [
          Text(
            note.title,
            style: textTheme.labelMedium!.copyWith(
              color: Colors.white
            ),
            maxLines: 1,
            overflow: .ellipsis,
          ),
    
          const SizedBox(height: 10),
    
          Text(
            note.content,
            style: textTheme.labelSmall!.copyWith(
              color: Colors.white.withValues(alpha: .7),
              fontSize: 12,
              height: 1.7
            ),
            maxLines: 2,
            overflow: .ellipsis,
          ),
    
          const SizedBox(height: 10),
    
          Row(
            spacing: 8,
            children: [
    
              Image.asset(
                note.language.displayImage,
                width: 25,
                height: 25,
              ),
              
              Text(
                note.language.displayName,
                style: textTheme.labelSmall!.copyWith(
                  color: Colors.white.withValues(alpha: .4)
                ),
                maxLines: 1,
                overflow: .ellipsis,
              )
            ],
          ),
        ],
      ),
    );
  }
}