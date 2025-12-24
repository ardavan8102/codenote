import 'package:code_note/core/models/hive/note_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final notesBoxProvider = Provider<Box<NoteModel>>((ref) {
  return Hive.box<NoteModel>('notes');
});

final notesControllerProvider =
    AsyncNotifierProvider<NotesController, List<NoteModel>>(
        NotesController.new);

class NotesController extends AsyncNotifier<List<NoteModel>> {
  late Box<NoteModel> _box;

  @override
  Future<List<NoteModel>> build() async {
    _box = ref.read(notesBoxProvider);

    _box.watch().listen((_) {
      state = AsyncData(_getSortedNotes());
    });

    return _getSortedNotes();
  }

  List<NoteModel> _getSortedNotes() {
    final notes = _box.values.toList();

    notes.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.updatedAt.compareTo(a.updatedAt);
    });

    return notes;
  }

  // ➕ Add Note
  Future<void> addNote(NoteModel note) async {
    state = const AsyncLoading();

    await _box.put(note.id, note);
    state = AsyncData(_getSortedNotes());
  }

  // ✏️ Update
  Future<void> updateNote(NoteModel note) async {
    await note.save();
    state = AsyncData(_getSortedNotes());
  }

  // 🗑 Delete
  Future<void> deleteNote(String id) async {
    await _box.delete(id);
    state = AsyncData(_getSortedNotes());
  }

  // 📌 Toggle Pin
  Future<void> togglePin(NoteModel note) async {
    note.isPinned = !note.isPinned;
    note.updatedAt = DateTime.now();
    await note.save();

    state = AsyncData(_getSortedNotes());
  }
}