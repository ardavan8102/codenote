import 'package:code_note/core/controllers/note_controller.dart';
import 'package:code_note/core/helpers/language_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final notesAsync = ref.watch(notesControllerProvider);

    return notesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (notes) {
        if (notes.isEmpty) {
          return const Center(child: Text('No notes yet'));
        }

        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return ListTile(
              title: Text(note.title),
              leading: Image.asset(note.language.displayImage),
            );
          },
        );
      },
    );
  }
}