import 'package:code_note/const/dimens.dart';
import 'package:code_note/core/controllers/note_controller.dart';
import 'package:code_note/presentation/view/single_pages/single_note_page.dart';
import 'package:code_note/presentation/widgets/appbars/just_text_appbar.dart';
import 'package:code_note/presentation/widgets/containers/notes_grid_item.dart';
import 'package:flutter/cupertino.dart';
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
              TopAppBarJustText(title: 'یادداشت ها'),

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

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(builder: (_) => SingleNotePage(note: note))
                        );
                      },
                      child: NotesGridViewItem(
                        size: size,
                        note: note,
                        textTheme: textTheme
                      )
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}