import 'package:code_note/const/colors.dart';
import 'package:code_note/const/dimens.dart';
import 'package:code_note/core/controllers/note_controller.dart';
import 'package:code_note/core/helpers/language_extention.dart';
import 'package:code_note/core/models/hive/note_model.dart';
import 'package:code_note/presentation/widgets/containers/notes_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final notesAsync = ref.watch(notesControllerProvider);

    final size = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;

    return notesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (notes) {
        if (notes.isEmpty) {
          return const Center(
            child: Text(
              'یادداشتی وجود نداره',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          );
        }

        return Padding(
          padding: EdgeInsets.all(Dimens.mainScaffoldPadding(context)),
          child: Column(
            children: [
              
              // appbar
              topAppBar(size, textTheme),

              const SizedBox(height: 30),

              // notes
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    
                    final note = notes[index];

                    return NotesGridViewItem(size: size, note: note, textTheme: textTheme);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container topAppBar(Size size, TextTheme textTheme) {
    return Container(
      height: size.height * .08,
      width: size.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppSolidColors.sectionDarkBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: .center,
      child: Text(
        'یادداشت ها',
        style: textTheme.titleSmall!.copyWith(color: Colors.white),
      ),
    );
  }
}